import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodtek_app/core/constants/text_styles.dart';


import '../../core/routes/app_routes.dart';
import 'onboarding/on_boarding_screen2.dart';



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
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding2);

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
              'assets/images/splash_bg.jpg', // Ensure you add this image to your assets
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
