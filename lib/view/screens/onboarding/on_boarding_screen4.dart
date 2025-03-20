import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/routes/app_routes.dart';

class OnBoardingScreen4 extends StatelessWidget {
  const OnBoardingScreen4({Key? key}) : super(key: key);

  Future<void> _handleTurnOnLocation(BuildContext context) async {
    bool permissionGranted = await _requestLocationPermission();

    if (permissionGranted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      _showPermissionDeniedDialog(context);
    }
  }

  void _handleCancel(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  Future<bool> _requestLocationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();

    return statuses[Permission.location]?.isGranted ?? false;
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permission Required"),
          content: const Text("Please enable location to continue."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
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
                  child: Column(
                    children: [
                      const SizedBox(height: 195),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
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
