class AppModel {
  final String name;
  final String packageName;
  int totalUsage; // Total penggunaan dalam detik
  bool
      isWithinLimit; // Menyimpan status apakah penggunaan sesuai timer atau tidak

  AppModel({
    required this.name,
    required this.packageName,
    this.totalUsage = 0,
    this.isWithinLimit = true, // default true
  });
}
