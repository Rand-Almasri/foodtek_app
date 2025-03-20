import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../core/widgets/CustomButton.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _updatePassword(BuildContext context) async {
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showAlert(context, "Error", "Both fields are required.");
      return;
    }

    if (newPassword != confirmPassword) {
      _showAlert(context, "Error", "Passwords do not match.");
      return;
    }

    LoginController loginController = LoginController(users: []);
    await loginController.updatePassword(widget.email, newPassword);

    // Show the custom success dialog
    showSuccessDialog(context);
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 100),
                    // Confetti Image
                    Image.asset(
                      'assets/images/alert.png', // Ensure this image exists in assets
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close Dialog
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Go to Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
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
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(context, '/resetpasswordscreen'),
                              child: Icon(Icons.arrow_back, size: 20),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Want to try with my current password?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                            TextField(
                              controller: newPasswordController,
                              obscureText: !_isNewPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "********",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isNewPasswordVisible = !_isNewPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Confirm Password Field
                            const Text(
                              "Confirm New Password",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "********",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                              text: "Update Password",
                              onPressed: () => _updatePassword(context),
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
