import 'package:flutter/material.dart';
import 'constant_colors.dart';
class AppTextStyles {
  static const TextStyle onboardingHeading = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.0, // 100% line-height
    letterSpacing: 0.0,
    color: AppColors.secondary, // Directly setting the text color here
  );
  static const TextStyle onboardingtext = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.0, // 100% line-height
    letterSpacing: -0.01, // -1% letter-spacing
    color: AppColors.secondary, // Directly setting the text color here
  );
  static const TextStyle continueonbordingtext = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0, // 100% line-height
    letterSpacing: 0.0,
    color: AppColors.background, // Default text color (change as needed)
    // Background color
  );
  static const TextStyle onboardingskip = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0, // 100% line-height
    letterSpacing: 0.0,
    color: AppColors.secondary, // Background color
  );
  static const TextStyle appname = TextStyle(
    fontFamily: 'Protest Riot',
    fontWeight: FontWeight.w400,
    fontSize: 80,
    height: 1.0, // 100% line-height
    letterSpacing: 0.0,
    color: Colors.white, // Default color
  );

}