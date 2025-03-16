import 'package:flutter/material.dart';
import '../../../core/constants/constant_colors.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Map Image (Covers Top)
          Positioned(
            top: -150,
            left: -50,
            right: -50,
            child: SizedBox(
              width: 868,
              height: 400,
              child: Image.asset(
                'assets/images/backgrounimagelocation.png', // Replace with your image
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.luminosity, // Apply the blend mode, // Adjust transparency if needed
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(), // Pushes content down for better balance

                  // Delivery Illustration
                  Image.asset(
                    'assets/images/onboarding_delivery.jpeg', // Replace with actual image
                    width: 328,
                    height: 219,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    "Turn On Your Location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "To continue, let your device turn on location, which uses Google's location service.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // "Yes, Turn It On" Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle location permission request
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(69),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF25AE4B),
                      ),
                      child: const Text(
                        "Yes, Turn It On",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // "Cancel" Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(69),
                        ),
                        backgroundColor: const Color(0xFFC2C2C2),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF455A64),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(), // Keeps buttons at bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
