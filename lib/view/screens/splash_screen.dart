import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodtek_app/core/constants/text_styles.dart';

import 'onboarding/on_boarding_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Navigate to Onboarding after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen1(
            onContinue: () {
              // Handle continue button press
              print("Continue button pressed");
            },
            onSkip: () {
              // Handle skip button press
              print("Skip button pressed");
            },
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, // Adjust status bar color
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/splash_bg.jpg',
              fit: BoxFit.cover, // Covers the whole screen
            ),
            // Centered App Title
            Center(
              child: Text(
                "Foodtek", // Change to your app's name
                style: AppTextStyles.appname,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
