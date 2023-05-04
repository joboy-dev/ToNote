// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/user_provider.dart';

class UserService {
  final UserView _userView = UserView();
  final UserProvider _userProvider = UserProvider();

  // Get user details service
  Future getUserDetails() async {
    final user = _userProvider.user;

    var data = await _userView.getUserDetails();
    var pic = await _userView.getUserProfilePicture();

    log('$data');

    // create a new user instance
    User userObj = User(
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      profilePicture: pic['profile_pic'],
    );

    // set user details in provider
    _userProvider.setUser(userObj);

    log('User Provider -- ${_userProvider.user!.email}');

    // return _userProvider.user;
  }
}
