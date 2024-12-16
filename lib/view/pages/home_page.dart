import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fomate_frontend/model/app_model.dart';
import 'package:fomate_frontend/viewmodel/timer_viewmodel.dart';
import 'package:fomate_frontend/utils/colors.dart';
import 'package:fomate_frontend/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = TimerViewModel();

  Map<String, bool> selectedApps = {
    'Instagram': false,
    'YouTube': false,
    'TikTok': false,
  };

  int timerDuration = 5;

  @override
  void initState() {
    super.initState();
    initializeService(); // Inisialisasi service saat HomePage dimulai
  }

  Future<void> _saveSelectedApps() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> selectedAppNames = selectedApps.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    await prefs.setStringList('selectedApps', selectedAppNames);
    await prefs.setInt('timerDuration', timerDuration);
  }

  void _startBackgroundService() async {
    final service = FlutterBackgroundService();
    if (!(await service.isRunning())) {
      service.startService();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Background service dimulai!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service sudah berjalan.')),
      );
    }
  }

  void _stopBackgroundService() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke("stopService");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Background service dihentikan!')),
      );
    }
  }

  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Aplikasi",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor_1),
                  ),
                  const SizedBox(height: 4),
                  Column(
                    children: selectedApps.keys.map((appName) {
                      return CheckboxListTile(
                        title: Text(appName,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.textColor_1)),
                        value: selectedApps[appName],
                        onChanged: (bool? value) {
                          setModalState(() {
                            selectedApps[appName] = value ?? false;
                          });
                        },
                        activeColor: AppColors.secondaryColor,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Durasi (jam)",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor_1),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setModalState(() {
                            if (timerDuration > 1) {
                              timerDuration--;
                            }
                          });
                        },
                      ),
                      Text("$timerDuration",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppColors.textColor_1,
                          )),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setModalState(() {
                            timerDuration++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                        ),
                        onPressed: () async {
                          await _saveSelectedApps(); // Simpan aplikasi yang dipilih dan durasi timer
                          Navigator.pop(context);
                        },
                        child: const Text("Set Timer",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor_0)),
                      ))
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fomate")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    onPressed: () => _showBottomModal(context),
                    child: const Text("Pilih Aplikasi dan Timer",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor_0)),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _startBackgroundService,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Mulai Service'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _stopBackgroundService,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Hentikan Service'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.apps.length,
                itemBuilder: (context, index) {
                  final app = viewModel.apps[index];
                  return Card(
                    child: ListTile(
                      title: Text(app.name),
                      subtitle: Text(
                          "Durasi Timer: ${viewModel.getTimerDuration()} menit\nStatus: ${app.isWithinLimit ? 'Dalam Batas' : 'Luar Batas'}",
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textColor_1)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
