class AppModel {
  final String packageName;
  final String name;
  int usageDuration;

  AppModel({
    required this.packageName,
    required this.name,
    this.usageDuration = 0,
  });

  void updateUsageDuration(int duration) {
    usageDuration += duration;
  }
}
