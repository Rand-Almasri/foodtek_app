import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/CustomTextField.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blurred Background Effect
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.7),
              ),
              // Main Dialog Content
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                 // mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 100),
                    // Confetti Image
                    Image.asset(
                      'assets/images/alert.png', // Your provided image
                      width: 400,
                      height: 300,
                    ),
                    const SizedBox(height: 20),
                    // Success Message
                    const Text(
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Password reset successfully",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Button to Go to Login Page
                    // CustomButton(
                    //   text: "Go to Login",
                    //   onPressed: () {
                    //
                    //     Navigator.pop(context); // Close Dialog
                    //     Navigator.pushReplacementNamed(context, '/login');
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Foodtek",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Protest Riot',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 110),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back Arrow
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(context, '/resetpasswordscreen'),
                              child: Icon(Icons.arrow_back, size: 20),
                            ),
                            const SizedBox(height: 10),
                            // Title
                            const Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Login Redirection Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Want to try with my current password?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                TextButton(
                                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // New Password Field
                            const Text(
                              "New Password",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: newPasswordController,
                              hintText: "********",
                              obscureText: true,
                            ),
                            const SizedBox(height: 15),
                            // Confirm Password Field
                            const Text(
                              "Confirm New Password",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: confirmPasswordController,
                              hintText: "********",
                              obscureText: true,
                            ),
                            const SizedBox(height: 30),
                            // Update Password Button
                            CustomButton(
                              text: "Update Password",
                              onPressed: () async {
                                // Simulate a password update delay
                                await Future.delayed(Duration(seconds: 1));

                                if (context.mounted) {
                                  showSuccessDialog(context);
                                }
                              },
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
