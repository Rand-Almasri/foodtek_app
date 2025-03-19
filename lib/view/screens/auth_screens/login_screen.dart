import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import '../../../controller/auth/login_controller.dart' show LoginController;
import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  final LoginController loginController;

  const LoginScreen({super.key, required this.loginController});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      String? savedEmail = prefs.getString('email');
      String? savedPassword = prefs.getString('password');

      if (savedEmail != null && savedPassword != null) {
        // Auto-login if credentials are saved
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _rememberMe = false;
          emailController.clear();
          passwordController.clear();
        });
      }
    } else {
      setState(() {
        _rememberMe = false;
        emailController.clear();
        passwordController.clear();
      });
    }
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', emailController.text.trim());
      await prefs.setString('password', passwordController.text.trim());
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
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
                          fontSize: 55,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Protest Riot',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don’t have an account?",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text("Sign Up",
                                      style: TextStyle(
                                        color: AppColors.primaryGreen,
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text("Email",
                                style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))]),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: emailController,
                              hintText: "Email@gmail.com",
                            ),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text("Password",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ))]),
                            const SizedBox(height: 5),
                            CustomTextField(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText: !_isPasswordVisible,
                              showSuffixIcon: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                      },
                                    ),
                                    const Text("Remember me"),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/resetpasswordscreen');
                                    },
                                    child: const Text("Forgot Password?",
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                        ))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: "Log In",
                              onPressed: () {
                                _saveCredentials();
                                widget.loginController.login(
                                  context,
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  _rememberMe,
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                            const Text("Or"),
                            const SizedBox(height: 15),
                            CustomButton(
                              text: "Continue with Google",
                              onPressed: () {},
                              color: Colors.white,
                              textColor: Colors.black,
                              imageIcon: Image.asset(
                                'assets/images/googlelogo.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(height: 17),
                            CustomButton(
                              text: "Continue with Facebook",
                              onPressed: () {},
                              color: Colors.white,
                              textColor: Colors.black,
                              icon: Icons.facebook,
                              iconColor: Colors.blue,
                              iconSize: 24,
                            ),
                            const SizedBox(height: 17),
                            CustomButton(
                              text: "Continue with Apple",
                              onPressed: () {},
                              color: Colors.white,
                              textColor: Colors.black,
                              icon: Icons.apple,
                              iconSize: 24,
                            ),
                            const SizedBox(height: 10),
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
