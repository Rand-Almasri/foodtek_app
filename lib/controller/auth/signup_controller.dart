import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birth date is required';
    }
    try {
      final formats = [
        DateFormat('dd/MM/yyyy'),
        DateFormat('MM/dd/yyyy'),
        DateFormat('yyyy/MM/dd'),
      ];

      bool isValid = false;
      for (var format in formats) {
        try {
          format.parseStrict(value);
          isValid = true;
          break;
        } catch (_) {}
      }

      if (!isValid) {
        return 'Enter a valid date';
      }
    } catch (e) {
      return 'Enter a valid date';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> storeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> userData = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'birthDate': birthDateController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
    };

    String userJson = jsonEncode(userData);
    await prefs.setString('user_${userData['email']}', userJson); // Store by email
  }


  Future<void> register(BuildContext context) async {
    await storeUserData();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful!')),
    );
  }

  Future<Map<String, String>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? birthDate = prefs.getString('birthDate');
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');

    if (name != null && email != null && birthDate != null && phone != null && password != null) {
      return {
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'phone': phone,
        'password': password,
      };
    }
    return null;
  }
}