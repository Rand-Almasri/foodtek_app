import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import 'package:foodtek_app/core/routes/app_routes.dart';
import 'package:foodtek_app/controller/auth/signup_controller.dart';

import '../../../core/widgets/CustomButton.dart';
import '../../../core/widgets/CustomTextField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _controller = SignupController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
            // Foodtek Logo
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  'Foodtek',
                  style: TextStyle(
                    fontFamily: 'Protest Riot',
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Form Container
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(height: 16),

                        // Sign up Title
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        // Already have an account section
                        Row(
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.login);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        // Full Name TextField
                        const Text(
                          "Full Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _controller.nameController,
                          hintText: 'Enter your full name',
                          validator: (value) => _controller.validateName(value),
                        ),

                        const SizedBox(height: 16),
                        // Email TextField
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _controller.emailController,
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => _controller.validateEmail(value),
                        ),

                        const SizedBox(height: 16),
                        // Birth of date TextField
                        const Text(
                          "Birth of date",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _controller.birthDateController,
                          hintText: 'DD/MM/YYYY',
                          keyboardType: TextInputType.datetime,
                          validator: (value) => _controller.validateBirthDate(value),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _controller.selectDate(context),
                          ),
                        ),

                        const SizedBox(height: 16),
                        // Phone Number TextField
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Country code selector
                            Container(
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Flag placeholder
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 24,
                                      width: 30,
                                      color: Colors.red,
                                      child: const Center(
                                        child: Text('+1', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Phone number field
                            Expanded(
                              child: CustomTextField(
                                controller: _controller.phoneController,
                                hintText: 'Enter your phone number',
                                keyboardType: TextInputType.phone,
                                validator: (value) => _controller.validatePhone(value),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        // Password TextField
                        const Text(
                          "Set Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _controller.passwordController,
                          hintText: 'Create a password',
                          obscureText: true,
                          showSuffixIcon: true,
                          validator: (value) => _controller.validatePassword(value),
                        ),

                        const SizedBox(height: 24),
                        // Register Button
                        CustomButton(
                          text: 'Register',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _controller.register(context);
                            }
                          },
                          color: AppColors.primaryGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}