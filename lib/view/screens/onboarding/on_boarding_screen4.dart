import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/routes/app_routes.dart';

class OnBoardingScreen4 extends StatelessWidget {
  const OnBoardingScreen4({Key? key}) : super(key: key);

  Future<void> _handleTurnOnLocation(BuildContext context) async {
    final permissionGranted = await _requestLocationPermission();
    permissionGranted
        ? Navigator.pushReplacementNamed(context, AppRoutes.login)
        : _showPermissionDeniedDialog(context);
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text("Please enable location to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
          TextButton(
            onPressed: openAppSettings,
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Image.asset(
                          'assets/images/onboarding_delivery.jpeg',
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Turn On Your Location',
                        style: AppTextStyles.onboardingHeading,
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
                        onPressed: () => _handleTurnOnLocation(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Yes, Turn It On',
                          style: AppTextStyles.continueonbordingtext,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, AppRoutes.login),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFC2C2C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
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
    );
  }
}