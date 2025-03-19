class UserModel {
  final String? id;
  final String name;
  final String email;
  final String birthDate;
  final String phone;
  final String? profileImage;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.phone,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'phone': phone,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthDate: json['birthDate'],
      phone: json['phone'],
      profileImage: json['profileImage'],
    );
  }
}
