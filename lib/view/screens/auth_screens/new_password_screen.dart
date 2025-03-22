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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/alert.png', width: 200, height: 150),
                const SizedBox(height: 20),
                const Text(
                  "Congratulations!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Password reset successfully",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text("Go to Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth > 600 ? 400 : constraints.maxWidth,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Foodtek",
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(context, '/resetpasswordscreen'),
                                child: Icon(Icons.arrow_back, size: 20),
                              ),
                              const SizedBox(height: 10),
                              const Text("Reset Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 10),
                              TextField(
                                controller: newPasswordController,
                                obscureText: !_isNewPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "New Password",
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isNewPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() => _isNewPasswordVisible = !_isNewPasswordVisible);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: confirmPasswordController,
                                obscureText: !_isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "Confirm New Password",
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
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
              ),
            ),
          );
        },
      ),
    );
  }
}
