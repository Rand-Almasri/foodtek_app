import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import '../../data/models/user_model.dart';

class LoginController {
  final List<UserModel> users;

  LoginController({required this.users});

  Future<void> saveUserCredentials(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setBool('rememberMe', true);
  }

  Future<Map<String, String>?> getUserByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_$email');

    if (userJson != null) {
      return Map<String, String>.from(jsonDecode(userJson));
    }
    return null;
  }

  UserModel? findUserByEmail(String email) {
    return users.firstWhereOrNull((user) => user.email == email);
  }

  Future<void> login(BuildContext context, String email, String password, bool rememberMe) async {
    Map<String, String>? userData = await getUserByEmail(email);

    if (userData == null) {
      _showErrorDialog(context, "Email not found.");
      return;
    }

    if (userData['password'] != password) {
      _showErrorDialog(context, "Incorrect password.");
      return;
    }

    if (rememberMe) {
      await _saveCredentials(email, password);
    } else {
      await _clearCredentials();
    }

    // Login successful
    Navigator.pushNamed(context, '/homescreen');
  }

  Future<void> _saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_email', email);
    await prefs.setString('saved_password', password);
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_email');
    await prefs.remove('saved_password');
  }

  Future<Map<String, String>?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('saved_email');
    String? password = prefs.getString('saved_password');

    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Login Failed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }


}
