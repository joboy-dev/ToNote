import 'package:isar/isar.dart';
import 'package:todoey/entities/todo.dart';

import 'note.dart';

part 'user.g.dart';

/// THIS IS USED IN SIGNING UP OF THE USER
class UserModel {
  int? id;
  String firstName, lastName, email, password, password2;
  String? profilePicture;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.password2,
    this.profilePicture,
  });
}

/// USED IN GETTING AND STORING USER DETAILS IN LOCAL DB
@Collection()
class User {
  // Id id = Isar.autoIncrement;
  Id? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePicture;
  // bool darkMode = false;

  // Foreign keys
  var todos = IsarLinks<Todo>();
  var notes = IsarLinks<Note>();

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profilePicture: json['profile_pic'],
    );
  }

  // Script to run for build_runner
  // flutter pub run build_runner build --delete-conflicting-outputs
}
