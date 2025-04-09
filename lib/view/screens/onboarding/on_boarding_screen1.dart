import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/routes/app_routes.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({Key? key}) : super(key: key);

  void _handleContinue(BuildContext context) =>
      Navigator.pushNamed(context, AppRoutes.onboarding2);

  void _handleSkip(BuildContext context) =>
      Navigator.pushNamed(context, AppRoutes.login);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundonboardingscreenss.JPG'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: Image.asset(
                          'assets/images/onboarding_welcome.jpeg',
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 16),
                        child: Text(
                          'Welcome To Sahlah',
                          style: AppTextStyles.onboardingHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _handleContinue(context),
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
                          onPressed: () => _handleSkip(context),
                          child: Text(
                            'Skip',
                            style: AppTextStyles.onboardingskip,
                          ),
                        ),
                        Row(
                          children: [
                            _buildDot(isActive: true),
                            _buildDot(isActive: false),
                            _buildDot(isActive: false),
                          ],
                        ),
                        IconButton(
                          onPressed: () => _handleContinue(context),
                          icon: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
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
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}