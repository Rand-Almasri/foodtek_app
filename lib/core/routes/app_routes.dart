import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/splash.dart';
import 'package:foodtek_app/view/screens/onboarding/on_boarding_screen2.dart';
import 'package:foodtek_app/view/screens/onboarding/location_permission_screen.dart';
class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding2 = '/onboarding2';
  static const String locationPermission = '/locationPermission';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding2:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen2());
      case locationPermission:
        return MaterialPageRoute(builder: (_) => const LocationPermissionScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
