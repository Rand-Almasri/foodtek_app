import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../core/constants/text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onContinue;
  final VoidCallback onSkip;
  final int currentIndex;
  final int totalScreens;

  const OnboardingScreen({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onContinue,
    required this.onSkip,
    required this.currentIndex,
    required this.totalScreens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          /// Background Map Image (Positioned with your settings)
          Positioned(
            top: 40, // Adjusted to match location screen style
            left: 20,
            right: 20,
            child: Image.asset(
              'assets/images/backgroundonbordingscreen.jpg', // Replace with your map image path
              width: 900,
              height: 200,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.luminosity,
              // Matching blend mode
            ),
          ),

          /// Main Content
          Column(
            children: [
              const SizedBox(height: 230), // Adjusted for layout alignment

              /// Onboarding Main Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(

                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1, bottom: 16),
                child: Text(
                  title,
                  style: AppTextStyles.onboardingHeading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.onboardingtext,
                ),
              ),
              const Spacer(),

              /// Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue',
                          style: AppTextStyles.continueonbordingtext,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: onSkip,
                          child: Text(
                            'Skip',
                            style: AppTextStyles.onboardingskip,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            totalScreens,
                                (index) => _buildDot(isActive: index == currentIndex),
                          ),
                        ),
                        IconButton(
                          onPressed: onContinue,
                          icon: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.primaryGreen),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColors.primaryGreen,
                              size: 20,
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
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
