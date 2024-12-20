import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fomate_frontend/model/app_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Aplikasi kembali ke foreground, mulai monitoring
      stopMonitoring();
    } else if (state == AppLifecycleState.paused) {
      // Aplikasi masuk ke background, tetapi tetap memantau penggunaan aplikasi
      startMonitoring();
    }
  }

  void startMonitoring() async {
    if (isMonitoring) return;
    isMonitoring = true;

    print("Monitoring started");

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
    _timer?.cancel();
    isMonitoring = false;

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

      removeApp(app);
    }

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

    await Future.delayed(const Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.show(
      0,
      'Friendly Reminder!',
      'You\'ve been using $appName for ${usageDuration.toString()} minute(s)!',
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
