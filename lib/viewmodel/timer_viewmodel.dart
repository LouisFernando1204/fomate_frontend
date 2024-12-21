import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fomate_frontend/model/app_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fomate_frontend/main.dart';
import 'package:fomate_frontend/utils/colors.dart';

class TimerViewModel with ChangeNotifier, WidgetsBindingObserver {
  final List<AppModel> apps = [];
  Timer? _timer;
  Map<String, DateTime> appStartTimes = {};
  int timerDuration = 5;
  bool isMonitoring = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TimerViewModel() {
    WidgetsBinding.instance.addObserver(this);
    _initializeNotifications();
  }

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

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      for (final appName in appStartTimes.keys) {
        final startTime = appStartTimes[appName]!;
        print("Start time: ${startTime}");

        final usageDuration = DateTime.now().difference(startTime).inMinutes;
        print("USAGE DURATION (in minutes): $usageDuration");

        final app = apps.firstWhere(
          (app) => app.name == appName,
          orElse: () => AppModel(packageName: appName, name: appName),
        );

        app.updateUsageDuration(usageDuration);

        print("APP NAME: " + app.name);
        print("APP USAGE DURATION: " + app.usageDuration.toString());

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final currentContext = navigatorKey.currentContext;
          if (currentContext != null) {
            _showUsagePopup(currentContext, appName, startTime, usageDuration);
          }
        });

        removeApp(app);
        print("APP LIST: " + apps.toString());
      }
      stopMonitoring();
    } else if (state == AppLifecycleState.paused) {
      if (apps.length > 0) {
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Usage Summary'),
          content: Text(
              'You\'ve been using ${appName[0].toUpperCase() + appName.substring(1)}\n\n'
              'Start Time: $startFormatted\n'
              'End Time: $endFormatted\n'
              'Duration: $usageDuration minute(s).'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondaryColor, // Set warna teks
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
      final appUsage = await AppUsage().getAppUsage(
        now.subtract(const Duration(seconds: 1)),
        now,
      );
      print("APP USAGE: " + appUsage.toString());

      if (appUsage.isNotEmpty) {
        AppUsageInfo? currentApp;

        for (var usage in appUsage) {
          if (apps.any((app) => app.name == usage.appName)) {
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
