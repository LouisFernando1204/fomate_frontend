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
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = CurveTween(curve: Curves.easeInOut);
            var fadeAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
        );
      },
    ),
     GoRoute(
      path: '/register',
      name: 'Register Page',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = CurveTween(curve: Curves.easeInOut);
            var fadeAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
        );
      },
    ),
     GoRoute(
      path: '/login',
      name: 'Login Page',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = CurveTween(curve: Curves.easeInOut);
            var fadeAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
        );
      },
    ),
     GoRoute(
      path: '/home',
      name: 'Home Page',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = CurveTween(curve: Curves.easeInOut);
            var fadeAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/content_list',
      name: 'Content List Page',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: ContentListPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/content_detail/:contentId',
      name: 'Content Detail Page',
      pageBuilder: (context, state) {
        final contentId = state.pathParameters['contentId'].toString();
        return CustomTransitionPage(
          child: ContentDetailPage(contentId: contentId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/pricing/:contentId',
      name: 'Pricing Page',
      pageBuilder: (context, state) {
        final contentId = state.pathParameters['contentId'].toString();
        return CustomTransitionPage(
          child: PricingPage(contentId: contentId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),
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
