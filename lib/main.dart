import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fomate_frontend/view/pages/pages.dart'; // Pastikan Anda mengganti path ini ke lokasi sebenarnya dari PricePage

void main() async {
  print("Starting app...");
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pricing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PricePage(), // Mengganti halaman utama menjadi PricePage
    );
  }
}
