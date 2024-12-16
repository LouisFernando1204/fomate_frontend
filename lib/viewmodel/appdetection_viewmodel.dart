import 'package:flutter/services.dart';

class AppDetectionService {
  static const MethodChannel _channel =
      MethodChannel('com.fomate.app_detection');

  Future<String?> getForegroundApp() async {
    try {
      final String? appName =
          await _channel.invokeMethod<String>('getForegroundApp');
      return appName;
    } catch (e) {
      return null;
    }
  }
}
