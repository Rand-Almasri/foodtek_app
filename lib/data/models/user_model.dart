import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String phone;
  final String? profileImage;
  final String? token; // Optional token for session handling

  UserModel({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.phone,
    this.profileImage,
    this.token,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(); // ✅ Generates a unique ID if not provided

  ///  Convert the user object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'birthDate': birthDate,
      'phone': phone,
      'profileImage': profileImage,
      'token': token,
    };
  }

  ///  Create a user object from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '', // ✅ Ensures password is always set
      birthDate: json['birthDate'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      profileImage: json['profileImage'] as String?,
      token: json['token'] as String?,
    );
  }

  ///  Convert object to JSON string
  String toJsonString() => jsonEncode(toJson());

  ///  Create a user object from a JSON string
  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }
}
