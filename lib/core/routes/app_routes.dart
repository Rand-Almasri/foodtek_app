import 'package:flutter/material.dart';
import 'package:foodtek_app/view/screens/auth_screens/login_screen.dart';
import 'package:foodtek_app/view/screens/auth_screens/new_password_screen.dart';
import 'package:foodtek_app/view/screens/auth_screens/reset_screen.dart';
import 'package:foodtek_app/view/screens/auth_screens/signup_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/favorites_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/home_screen.dart';
import 'package:foodtek_app/view/screens/home_screens/main_screen.dart';

import 'package:foodtek_app/view/screens/splash_screen.dart';

import '../../controller/auth/login_controller.dart';
import '../../view/screens/onboarding/on_boarding_screen1.dart';
import '../../view/screens/onboarding/on_boarding_screen2.dart';
import '../../view/screens/onboarding/on_boarding_screen3.dart';
import '../../view/screens/onboarding/on_boarding_screen4.dart';
import 'package:foodtek_app/view/screens/auth_screens/verification_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String onboarding3 = '/onboarding3';
  static const String onboarding4 = '/onboarding4';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetpasswordscreen = '/resetpasswordscreen';
  static const String newpasswordscreen = '/newpasswordscreen';
  static const String mainscreen = '/mainscreen';
  static const String verification = '/verification';
  static const String homescreen = '/homescreen';
  static const String favoritesscreen = '/favoritesscreen';
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
      case mainscreen:
        return MaterialPageRoute(builder: (_) =>  MainScreen());
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            loginController: LoginController(users: []),
          ),
        );
      case resetpasswordscreen:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
      case newpasswordscreen:
        return MaterialPageRoute(builder: (_) => NewPasswordScreen(email: '',));
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case verification:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case homescreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case favoritesscreen:
        return MaterialPageRoute(builder: (_) =>  FavoriteScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

