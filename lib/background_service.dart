import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_usage/app_usage.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Fomate Service',
      initialNotificationContent: 'Service berjalan...',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Konfigurasi notifikasi
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Variabel pemantauan
  Timer? appTimer;
  List<String> selectedApps =
      prefs.getStringList('selectedApps') ?? []; // Aplikasi yang dipilih
  int timerDuration =
      prefs.getInt('timerDuration') ?? 5; // Durasi timer dalam menit

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "Fomate Service",
          content: "Memantau aplikasi yang dibuka...",
        );
      }
    }

    // Deteksi aplikasi yang sedang berjalan
    final currentApp =
        await getCurrentApp(); // Fungsi ini memantau aplikasi aktif
    if (selectedApps.contains(currentApp)) {
      if (appTimer == null) {
        appTimer = Timer(Duration(minutes: timerDuration), () {
          // Notifikasi ketika waktu habis
          flutterLocalNotificationsPlugin.show(
            888,
            'Fomate',
            'Waktu Anda di $currentApp telah habis!',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'main_channel',
                'Main Channel',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
          appTimer = null; // Reset timer
        });
      }
    } else {
      appTimer?.cancel(); // Batalkan timer jika aplikasi keluar
      appTimer = null;
    }
  });
}

// Fungsi untuk mendapatkan aplikasi yang sedang dibuka (placeholder)
Future<String> getCurrentApp() async {
  try {
    // Ambil waktu saat ini dan 1 menit sebelumnya
    DateTime endTime = DateTime.now();
    DateTime startTime = endTime.subtract(const Duration(minutes: 1));

    // Ambil daftar aplikasi yang digunakan dalam rentang waktu
    List<AppUsageInfo> usageList =
        await AppUsage().getAppUsage(startTime, endTime);

    // Temukan aplikasi yang terakhir digunakan (dengan waktu penggunaan terbesar)
    if (usageList.isNotEmpty) {
      usageList.sort(
          (a, b) => b.usage.compareTo(a.usage)); // Urutkan berdasarkan durasi
      return usageList.first.packageName; // Nama package aplikasi terakhir
    } else {
      return "unknown"; // Jika tidak ada data penggunaan aplikasi
    }
  } catch (e) {
    // Jika ada error, return "unknown"
    print("Error saat mengambil aplikasi aktif: $e");
    return "unknown";
  }
}
