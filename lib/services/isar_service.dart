// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';

class IsarService {
  late Future<Isar> db;
  final UserView userView = UserView();

  IsarService() {
    db = openDB();
  }

  /// Set up DB at app start
  Future<Isar> openDB() async {
    // Check if there is an active DB instance
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      // open isar db
      await Isar.open(
        [UserSchema, TodoSchema, NoteSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  // -------------------------USERS---------------------------

  /// Function to save a new user at login
  Future saveUser(BuildContext context, User newUser) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.users.putSync(newUser));

    // set new user in provider
    Provider.of<UserProvider>(context, listen: false).setUser(newUser);
    log('${Provider.of<UserProvider>(context, listen: false).user?.email}');

    return newUser;
  }

  /// Function to get logged in user details and set it in provider
  Future<User?> getUserDetails(BuildContext context) async {
    // initialize isar
    final isar = await db;

    // get user details from backend
    var userData = await userView.getUserDetails();

    // check for errors in the request
    if (userData == 401) {
      return null;
    } else {
      // Debugging
      log('(IsarService) $userData');
      log('(IsarService) user id - ${userData['id']}');

      // create a read transaction to get user details
      final userDoc = await isar.txn(() => isar.users.get(userData['id']));

      log('(IsarService) UserDoc -- $userDoc');

      if (userDoc != null) {
        log('UserDoc -- ${userDoc.firstName}');

        // store user data in provider. listen must be false
        Provider.of<UserProvider>(context, listen: false).setUser(userDoc);
        log('${Provider.of<UserProvider>(context, listen: false).user?.email}');
        return userDoc;
      } else {
        return null;
      }
    }
  }

  Future<User?> updateUserDetails(
    BuildContext context,
    String email,
    String firstName,
    String lastName,
  ) async {
    // initialize isar
    final isar = await db;

    // get user details from backend
    var userData = await userView.getUserDetails();

    // check for errors in the request
    if (userData == 401) {
      return null;
    } else {
      // create a read transaction to get user details
      final userDoc = await isar.txn(() => isar.users.get(userData['id']));

      log('(IsarService) UserDoc -- $userDoc');

      if (userDoc != null) {
        log('UserDoc -- ${userDoc.firstName}');

        userDoc.email = email;
        userDoc.firstName = firstName;
        userDoc.lastName = lastName;

        // store user data in provider. listen must be false
        Provider.of<UserProvider>(context, listen: false).setUser(userDoc);
        log('${Provider.of<UserProvider>(context, listen: false).user?.email}');
        return userDoc;
      } else {
        return null;
      }
    }
  }

  Future toggleTheme(BuildContext context, bool darkMode) async {
    final isar = await db;

    // get user details from backend
    var userData = await userView.getUserDetails();

    // check for errors in the request
    if (userData == 401) {
      return null;
    } else {
      // create a read transaction to get user details
      final userDoc = await isar.txn(() => isar.users.get(userData['id']));

      log('(IsarService) UserDoc -- $userDoc');

      if (userDoc != null) {
        log('UserDoc -- ${userDoc.darkMode}');

        userDoc.darkMode = !darkMode;

        // store user data in provider. listen must be false
        Provider.of<UserProvider>(context, listen: false).setUser(userDoc);
        log('${Provider.of<UserProvider>(context, listen: false).user?.email}');
        return userDoc.darkMode;
      } else {
        return null;
      }
    }
  }

  // ------------------------TODOS----------------------------

  /// Function to add new todo to Isar DB
  Future saveTodo(Todo todo) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.todos.putSync(todo));
  }

  // ------------------------NOTES-----------------------------

  /// Function to add new note to Isar DB
  Future saveNote(Note note) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.notes.putSync(note));
  }
}
