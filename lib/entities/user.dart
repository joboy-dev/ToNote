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

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     firstName: json['first_name'],
  //     lastName: json['last_name'],
  //     email: json['email'],
  //     password: json['password'],
  //     password2: json['password2'],
  //   );
  // }
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
  bool? darkMode;

  // Foreign keys
  final todos = IsarLinks<Todo>();
  final notes = IsarLinks<Note>();

  // Script to run for build_runner
  // flutter pub run build_runner build --delete-conflicting-outputs
}
