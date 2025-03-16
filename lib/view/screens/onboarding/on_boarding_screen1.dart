import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class OnboardingScreen1 extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  const OnboardingScreen1({
    Key? key,
    required this.onContinue,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Main illustration
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'assets/images/onboarding_welcome.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Welcome text
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: Text(
                        'Welcome To Sahlah',
                        style: AppTextStyles.onboardingHeading,
                      ),
                    ),

                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Enjoy A Fast And Smooth Food Delivery At Your Doorstep',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboardingtext,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom navigation section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: AppTextStyles.continueonbordingtext,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Skip and dots row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip text
                      TextButton(
                        onPressed: onSkip,
                        child: Text(
                          'Skip',
                          style: AppTextStyles.onboardingskip,
                        ),
                      ),

                      // Indicator dots
                      Row(
                        children: [
                          _buildDot(isActive: true),
                          _buildDot(isActive: false),
                          _buildDot(isActive: false),
                        ],
                      ),

                      // Next arrow button
                      IconButton(
                        onPressed: onContinue,
                        icon: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.primary),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}