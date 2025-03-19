import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/CustomTextField.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

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
                      const SizedBox(height: 140),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Keep everything aligned closely
                              mainAxisSize: MainAxisSize.min, // Prevent extra spacing
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                                  child: Icon(Icons.arrow_back, size: 16), // Reduced size for better alignment
                                ),
                                SizedBox(width: 4), // Decreased space between components
                                Text(
                                  "Back to",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                TextButton(
                                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero), // Remove extra padding
                                    minimumSize: MaterialStateProperty.all(Size(0, 0)), // Avoid extra height
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce touch area
                                    visualDensity: VisualDensity.compact, // Minimize space
                                  ),

                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14, // Match text sizes
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "page",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Rest Password",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 58),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Enter your E-mail or phone and we’ll send you a link to get back into your account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: emailController,
                              hintText: "Email@gmail.com",
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                              text: "Send",
                              onPressed: () {
                                // Handle password reset logic
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