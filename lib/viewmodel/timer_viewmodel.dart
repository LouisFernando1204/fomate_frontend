import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fomate_frontend/model/app_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimerViewModel with ChangeNotifier, WidgetsBindingObserver {
  final List<AppModel> apps = [];
  Timer? _timer;
  String? _currentApp;
  Map<String, DateTime> appStartTimes = {}; // Waktu mulai aplikasi digunakan
  int timerDuration = 5; // durasi timer dalam menit

  // Variabel untuk melacak status aplikasi
  bool isMonitoring = false;

  // Untuk notifikasi
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TimerViewModel() {
    WidgetsBinding.instance.addObserver(this); // Menambahkan observer
    _initializeNotifications();
  }

  // Inisialisasi pengaturan notifikasi
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@drawable/fomate_logo'); // Gunakan nama file yang baru

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this); // Menghapus observer saat widget dibuang
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Aplikasi kembali ke foreground, mulai monitoring
      startMonitoring();
    } else if (state == AppLifecycleState.paused) {
      // Aplikasi masuk ke background, tetapi tetap memantau penggunaan aplikasi
      // Tidak perlu menghentikan monitoring, cukup pastikan monitoring tetap berjalan
      if (!isMonitoring) {
        startMonitoring();
      }
    }
  }

  // Fungsi untuk memulai pemantauan
  Future<void> startMonitoring() async {
    if (isMonitoring)
      return; // Jika sudah mulai monitoring, tidak perlu diulang

    print("Monitoring started");
    isMonitoring = true;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final now = DateTime.now();
      final appUsage = await AppUsage().getAppUsage(
        now.subtract(Duration(minutes: timerDuration)),
        now,
      );

      if (appUsage.isNotEmpty) {
        final appName = appUsage.last.packageName;

        // Cari aplikasi yang digunakan
        final currentAppModel = apps.firstWhere(
          (app) => app.packageName == appName,
          orElse: () => AppModel(packageName: appName, name: appName),
        );

        if (currentAppModel != null) {
          // Periksa waktu awal penggunaan
          if (!appStartTimes.containsKey(appName)) {
            appStartTimes[appName] = now;
          }

          // Hitung total waktu penggunaan
          final startTime = appStartTimes[appName]!;
          final usageDuration = now.difference(startTime).inMinutes;

          // Perbarui model aplikasi
          currentAppModel.totalUsage = usageDuration; // dalam menit
          notifyListeners();

          // Tampilkan notifikasi jika waktu habis
          if (usageDuration >= timerDuration) {
            _showNotification(appName);
            appStartTimes.remove(appName); // Hapus agar tidak berulang
          }
        }
      }
    });
  }

  // Menampilkan notifikasi saat timer habis
  void _showNotification(String appName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Timer Habis',
      'Waktu penggunaan aplikasi $appName telah habis!',
      platformChannelSpecifics,
    );
  }

  // Fungsi untuk menghentikan pemantauan
  void stopMonitoring() {
    print("Monitoring stopped");
    _timer?.cancel();
    isMonitoring = false;
  }

  // Fungsi untuk mengecek apakah aplikasi sudah melebihi durasi timer yang ditetapkan
  void checkAppUsage() {
    for (var app in apps) {
      if (app.totalUsage >= timerDuration) {
        // Cek dalam menit
        app.isWithinLimit = true;
      } else {
        app.isWithinLimit = false;
      }
    }
    notifyListeners();
  }

  // Menambahkan aplikasi yang dipilih dan mengatur timer
  void setTimerDuration(int duration) {
    timerDuration = duration;
    notifyListeners();
  }

  int getTimerDuration() {
    return timerDuration;
  }

  // Tambahkan aplikasi yang dipilih dan mulai monitoring
  void addApp(AppModel app) {
    apps.add(app);
    startMonitoring(); // Mulai monitoring saat aplikasi ditambahkan
    notifyListeners();
  }

  // Hapus aplikasi dan hentikan monitoring jika perlu
  void removeApp(AppModel app) {
    apps.remove(app);
    notifyListeners();
  }
}
