part of 'model.dart';

class AppModel {
  String packageName;
  String appName;
  String startTime;
  String endTime;
  int timer;

  AppModel({
    required this.packageName,
    required this.appName,
    this.startTime = "",
    this.endTime = "",
    this.timer = 0,
  });
}
