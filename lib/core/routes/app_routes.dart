import 'package:flutter/material.dart';

import 'package:foodtek_app/view/screens/splash_screen.dart';
import '../../view/screens/onboarding/on_boarding_screen1.dart';
import '../../view/screens/onboarding/on_boarding_screen2.dart';
import '../../view/screens/onboarding/on_boarding_screen3.dart';
import '../../view/screens/onboarding/on_boarding_screen4.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String onboarding3 = '/onboarding3';
  static const String onboarding4 = '/onboarding4';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case onboarding2:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen2());
      case onboarding3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());
      case onboarding4:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen4());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}