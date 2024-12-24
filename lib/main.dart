import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fomate_frontend/model/model.dart';
import 'package:fomate_frontend/view/pages/home_page.dart';
import 'package:fomate_frontend/view/pages/pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await initializeDateFormatting('id_ID', null);
  runApp(MaterialApp.router(routerConfig: router));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Loading Page',
      builder: (context, state) => const ContentListPage(),
    ),
    GoRoute(
      path: '/content_list',
      name: 'Content List Page',
      builder: (context, state) => const ContentListPage(),
    ),
    // GoRoute(
    //   path: '/content_detail',
    //   name: 'Content Detail Page',
    //   builder: (context, state) {
    //     Content content = state.extra as Content;
    //     return ContentDetailPage(content: content);
    //   },
    // ),
    //  GoRoute(
    //   path: '/pricing',
    //   name: 'Pricing Page',
    //   builder: (context, state) {
    //     Content content = state.extra as Content;
    //     return const PricingPage(content: content);
    //   }
    // ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
