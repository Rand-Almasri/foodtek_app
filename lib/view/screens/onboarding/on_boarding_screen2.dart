import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import 'location_permission_screen.dart';
import 'onboardingscreens.dart';

class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      imagePath: 'assets/images/onboarding_delivery.jpeg',
      title: 'Get Delivery On Time',
      subtitle: 'Order Your Favorite Food Within The Plam Of Your Hand And The Zone Of Your Comfort',
      onContinue: () {
        // Navigate to next onboarding screen
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, AppRoutes.locationPermission);
      },
      currentIndex: 1,
      totalScreens: 3,
    );
  }
}
