import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/constant_colors.dart';
import 'package:foodtek_app/core/routes/app_routes.dart';
import 'package:foodtek_app/controller/auth/signup_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _controller = SignupController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String _selectedCountryCode = '+1';
  CountryCode _countryCode = CountryCode(code: 'US', dialCode: '+1');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _controller.birthDateController.text =
      "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _controller.register(context).then((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final bool isLargeScreen = screenSize.width > 900;

    final double logoFontSize = isLargeScreen ? 70 : (isTablet ? 60 : 48);
    final double headerFontSize = isLargeScreen ? 24 : (isTablet ? 20 : 18);
    final double textFontSize = isLargeScreen ? 16 : (isTablet ? 14 : 12);
    final double buttonHeight = isLargeScreen ? 50 : (isTablet ? 45 : 40);
    final double fieldHeight = isLargeScreen ? 52 : (isTablet ? 48 : 44);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Logo at the top
          Positioned(
            top: screenSize.height *  0.02,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Foodtek',
                style: TextStyle(
                  fontSize: logoFontSize,
                  color: Colors.white,
                  fontFamily: 'Protest Riot',
                ),
              ),
            ),
          ),

          // Responsive Form Container
          Center(
            child: Container(
              width: isLargeScreen
                  ? screenSize.width * 0.5
                  : (isTablet ? screenSize.width * 0.7 : screenSize.width * 0.85),
              constraints: BoxConstraints(
                maxWidth: 500,
                minWidth: 300,
              ),
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.05,
                horizontal: isTablet ? 40 : 20,
              ),
              padding: EdgeInsets.all(isTablet ? 30 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back, size: isTablet ? 28 : 24),
                          ),
                          const Spacer(),
                          Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: headerFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(width: isTablet ? 28 : 24),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),

                      // Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: textFontSize,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: textFontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.025),

                      // Full Name Field
                      _buildTextField(
                        label: 'Full Name',
                        controller: _controller.nameController,
                        validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                        labelSize: textFontSize,
                        fieldHeight: fieldHeight,
                        hintText: 'Lois Becket',
                      ),

                      // Email Field
                      _buildTextField(
                        label: 'Email',
                        controller: _controller.emailController,
                        validator: (value) => !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)
                            ? 'Enter valid email'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        labelSize: textFontSize,
                        fieldHeight: fieldHeight,
                        hintText: 'loisbecket@gmail.com',
                      ),

                      _buildDatePickerField(fieldHeight, textFontSize),

                      _buildPhoneField(fieldHeight, textFontSize),

                      _buildPasswordField(fieldHeight, textFontSize),

                      // Register Button
                      SizedBox(height: screenSize.height * 0.02),
                      SizedBox(
                        height: buttonHeight,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: textFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    required double labelSize,
    required double fieldHeight,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              style: TextStyle(fontSize: labelSize),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: labelSize, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(double fieldHeight, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight,
            child: TextFormField(
              controller: _controller.birthDateController,
              readOnly: true,
              onTap: _selectDate,
              validator: (value) => value!.isEmpty ? 'Please select birth date' : null,
              style: TextStyle(fontSize: textSize),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: Icon(Icons.calendar_today, size: textSize + 6, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: '18/03/2024',
                hintStyle: TextStyle(fontSize: textSize, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField(double fieldHeight, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone Number',
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                height: fieldHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CountryCodePicker(
                  onChanged: (CountryCode code) {
                    setState(() {
                      _countryCode = code;
                      _selectedCountryCode = code.dialCode ?? '+1';
                    });
                  },
                  initialSelection: 'US',
                  favorite: const ['US', 'CA', 'UK'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  flagWidth: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: TextStyle(fontSize: textSize),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: fieldHeight,
                  child: TextFormField(
                    controller: _controller.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.length < 10 ? 'Invalid phone number' : null,
                    style: TextStyle(fontSize: textSize),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      hintText: '(454) 726-0592',
                      hintStyle: TextStyle(fontSize: textSize, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(double fieldHeight, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Password',
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: fieldHeight,
            child: TextFormField(
              controller: _controller.passwordController,
              obscureText: !_isPasswordVisible,
              validator: (value) => value!.length < 6 ? 'Minimum 6 characters required' : null,
              style: TextStyle(fontSize: textSize),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    size: textSize + 6,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: '••••••••',
                hintStyle: TextStyle(fontSize: textSize, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}