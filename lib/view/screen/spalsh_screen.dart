import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodtek_app/core/constants/text_styles.dart';
class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Onboarding after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => OnboardingScreen()),
      // );
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
