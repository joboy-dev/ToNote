import 'dart:io';

/// THIS IS USED IN SIGNING UP OF THE USER
class UserModel {
  String firstName, lastName, email, password, password2;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.password2,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      password2: json['password2'],
    );
  }
}

/// USED IN GETTING USER DETAILS
class User {
  String firstName, lastName, email, profilePicture;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
  });
}
