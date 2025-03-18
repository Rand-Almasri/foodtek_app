import 'package:flutter/material.dart';
import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/text_styles.dart';

class OnBoardingScreen4 extends StatelessWidget {
  const OnBoardingScreen4({Key? key}) : super(key: key);

  void _handleTurnOnLocation(BuildContext context) {
    // Handle location permission logic here
  }

  void _handleCancel(BuildContext context) {
    Navigator.pop(context);
  }
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
                  child: Column(
                    children: [
                      const SizedBox(height: 195),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40,),
                        child: Image.asset(
                          'assets/images/onboarding_delivery.jpeg',
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Text(
                          'Turn On Your Location',
                          style: AppTextStyles.onboardingHeading,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'To continue, let your device turn on location, which uses Google\'s location service.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingtext,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () => _handleTurnOnLocation(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryGreen,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Yes, Turn It On',
                                  style: AppTextStyles.continueonbordingtext,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: TextButton(
                                onPressed: () => _handleCancel(context),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(69),
                                  ),
                                  backgroundColor: const Color(0xFFC2C2C2),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xFF455A64),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],


          ),
        ),
      ),
    );
  }

}