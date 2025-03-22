import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/CustomTextField.dart';
import 'new_password_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  Future<void> _checkEmail(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String enteredEmail = emailController.text.trim().toLowerCase();

    String? userJson = prefs.getString('user_$enteredEmail');

    if (userJson != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewPasswordScreen(email: enteredEmail),
        ),
      );
    } else {
      _showAlert(context, "Email not found", "The provided email is not registered.");
    }
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
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
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.arrow_back, size: 16),
                                  const SizedBox(width: 4),
                                  const Text("Back to", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  TextButton(
                                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      minimumSize: MaterialStateProperty.all(Size(0, 0)),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text("page", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Reset Password",
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 58),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Enter your E-mail and we’ll check if it exists to reset your password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: emailController,
                              hintText: "Email@gmail.com",
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                              text: "Send",
                              onPressed: () => _checkEmail(context),
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
