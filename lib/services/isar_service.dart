// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';

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
        [UserSchema, TodoSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  /// Function to remove a user upon log out
  Future removeUser() async {
    final iser = await db;
    var userData = await userView.getUserDetails();
    final query = iser.users.where().filter().idEqualTo(userData['id']).build();
    query.deleteAll();
  }

  /// Function to save a new user at login
  Future saveUser(User newUser) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.users.putSync(newUser));
  }

  /// Function to get logged in user details
  Future<User?> getUserDetails(BuildContext context) async {
  // Future<User?> getUserDetails() async {
    // initialize isar
    final isar = await db;

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
        Provider.of<UserProvider>(context, listen: false).setUser(userDoc);
        log('${Provider.of<UserProvider>(context, listen: false).user?.email}');
        return userDoc;
      } else {
        return null;
      }
    }
  }

  /// Function to update user details
  // Future updateDetails(User existingUser) async {
  //   final isar = await db;

  //   var userData = await userView.getUserDetails();

  //   final userDoc = await isar.txn(() => isar.users.get(userData['id']));

  //   if (userDoc != null) {}
  // }

  // Future<Stream<List<User>>> userStream() async {
  //   final isar = await db;
  //   final streamController = StreamController<List<User>>();

  //   var userData = await userView.getUserDetails();

  //   final query = isar.users.where().filter().idEqualTo(userData['id']).build();

  //   // listen for changes
  //   final listener = query.watchLazy();

  //   listener.listen((_) {
  //     // fetch updated data
  //     final users = query.findFirst();
  //     streamController.add(users as List<User>);
  //   });

  //   log('${streamController.stream}');

  //   return streamController.stream;
  // }
}
