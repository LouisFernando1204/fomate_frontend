part of 'viewmodel.dart';

class TimerViewModel with ChangeNotifier, WidgetsBindingObserver {
  final List<AppModel> apps = [];
  Timer? _timer;
  Map<String, DateTime> appStartTimes = {};
  int timerDuration = 5;
  bool isMonitoring = false;
  bool isTestingMode = true;
  bool scheduleAdded = false;
  bool isNotificationInProgress = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TimerViewModel() {
    WidgetsBinding.instance.addObserver(this);
    _initializeNotifications();
  }

  HomeViewModel homeViewModel = HomeViewModel();

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/fomate_logo');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await flutterLocalNotificationsPlugin.cancelAll();
      final appNames = List<String>.from(appStartTimes.keys);
      print("APP NAMES LENGTH: " + appNames.length.toString());

      for (final appName in appNames) {
        if (scheduleAdded) break;
        final startTime = appStartTimes[appName]!;
        final endTime = DateTime.now();
        final usageDuration = DateTime.now().difference(startTime).inMinutes;

        final app = apps.firstWhere(
          (app) => app.appName == appName,
          orElse: () => AppModel(packageName: appName, appName: appName),
        );

        app.startTime = startTime.toString();
        app.endTime = endTime.toString();
        app.timer = timerDuration;

        print("App Name " + app.appName);
        print("Start Time: ${startTime}");
        print("End Time: ${endTime}");
        print("Timer Duration: ${timerDuration}");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final currentContext = navigatorKey.currentContext;
          print("CURRENT CONTEXT: ${currentContext}");
          if (currentContext != null) {
            _showUsagePopup(currentContext, appName, startTime, usageDuration);
          }
        });

        var userData = await UserLocalStorage.getUserData();
        await homeViewModel.addSchedule(
            userData!.id!, appName, app.startTime, app.endTime, app.timer);

        int newHealth;
        final delay = usageDuration - timerDuration;

        if (delay <= 0) {
          newHealth = 100;
        } else if (delay > 0 && delay <= 10) {
          newHealth = 90;
        } else if (delay > 10 && delay <= 30) {
          newHealth = 70;
        } else if (delay > 30 && delay <= 60) {
          newHealth = 50;
        } else {
          newHealth = 30;
        }
        print("Delay: $delay minutes, New Health: $newHealth");

        await homeViewModel.updateHealth(userData!.id!, newHealth);

        scheduleAdded = true;

        removeApp(app);
        print("APP LIST: " + apps.toString());
      }
      stopMonitoring();
    } else if (state == AppLifecycleState.paused) {
      scheduleAdded = false;
      if (apps.isNotEmpty) {
        startMonitoring();
      }
    }
  }

  Future<void> _showUsagePopup(BuildContext context, String appName,
      DateTime startTime, int usageDuration) async {
    final startFormatted =
        "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";
    final endFormatted =
        "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";

    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          title: Text('Usage Summary'),
          content: Text(
              'You\'ve been using ${appName[0].toUpperCase() + appName.substring(1)}\n\n'
              'Start Time: $startFormatted\n'
              'End Time: $endFormatted\n'
              'Duration: $usageDuration minute(s).'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondaryColor,
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void startMonitoring() async {
    if (isMonitoring) return;
    isMonitoring = true;

    print("Monitoring started");
    print("Move to Background...");

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final now = DateTime.now();

      if (isNotificationInProgress) return;

      if (isTestingMode) {
        print("In Testing Mode!");
        final app = apps[0];
        appStartTimes[app.appName] ??= now;

        final startTime = appStartTimes[app.appName]!;
        print("START TIME: " + startTime.toString());
        final usageDuration = now.difference(startTime).inMinutes;
        print("USAGE DURATION: " + usageDuration.toString());

        if (usageDuration >= timerDuration) {
          print("CURRENT APP FINAL: " + app.appName);
          _showNotification(app.appName, usageDuration);
        }
        return;
      }

      final appUsage = await AppUsage().getAppUsage(
        now.subtract(const Duration(seconds: 1)),
        now,
      );
      print("APP USAGE: " + appUsage.toString());

      if (appUsage.isNotEmpty) {
        AppUsageInfo? currentApp;

        for (var usage in appUsage) {
          if (apps.any((app) => app.appName == usage.appName)) {
            currentApp = usage;
            break;
          }
        }

        if (currentApp != null) {
          final currentAppName = currentApp.appName;
          print("CURRENT APP: " + currentAppName);

          appStartTimes[currentAppName] ??= now;

          final startTime = appStartTimes[currentAppName]!;
          print("START TIME: " + startTime.toString());
          final usageDuration = now.difference(startTime).inMinutes;
          print("USAGE DURATION: " + usageDuration.toString());

          if (usageDuration >= timerDuration) {
            print("CURRENT APP FINAL: " + currentAppName);
            await _showNotification(currentAppName, usageDuration);
          }
        }
      }
    });
  }

  void stopMonitoring() {
    if (!isMonitoring) return;

    print("Monitoring stopped");
    print("Move to Foreground...");

    _timer?.cancel();
    isMonitoring = false;

    appStartTimes.clear();
    print("APP START TIMES: " + appStartTimes.toString());

    notifyListeners();
  }

  Future<void> _showNotification(String appName, int usageDuration) async {
    isNotificationInProgress = true;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('usage_timer_channel', 'Usage Timer',
            channelDescription: 'Notification for application usage time limit',
            importance: Importance.max,
            priority: Priority.high);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await Future.delayed(const Duration(seconds: 15));

    await flutterLocalNotificationsPlugin.show(
      0,
      'Friendly Reminder!',
      'You\'ve been using ${appName[0].toUpperCase() + appName.substring(1)} for ${usageDuration.toString()} minute(s)!',
      notificationDetails,
    );

    isNotificationInProgress = false;
  }

  List<AppModel> getAllApps() {
    return apps;
  }

  void addApp(AppModel app) {
    apps.add(app);
    notifyListeners();
  }

  void removeApp(AppModel app) {
    apps.remove(app);
    notifyListeners();
  }

  void setTimerDuration(int duration) {
    timerDuration = duration;
    notifyListeners();
  }
}
