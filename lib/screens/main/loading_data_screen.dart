// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/services/shared_preferences/user_shared_preferences.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';

class LoadingDataScreen extends StatefulWidget {
  const LoadingDataScreen({super.key});

  static const String id = 'loading_data';

  @override
  State<LoadingDataScreen> createState() => _LoadingDataScreenState();
}

class _LoadingDataScreenState extends State<LoadingDataScreen> {
  // map to store cached user data
  Map<String, dynamic> _cachedUserData = {};

  final UserView _userView = UserView();

  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();

  // initialize user provider
  final UserProvider _userProvider = UserProvider();

  // Function to get current logged in user details
  /* Since this is the very first screen, we will store all user data in a cache so
  that in other screens, the cached data can be set into the provider class
  and be easily used */
  Future<void> _getUserDetails() async {
    // get user data
    var data = await _userView.getUserDetails();

    // check if user data was successfully fetched to prevent errors
    if (data != 400 &&
        data != 401 &&
        data != 'Connection timed out' &&
        data != null) {
      log('User Data from gotten user details (LoadingData) -- $data');

      // get user profile picture
      var profilePic = await _userView.getUserProfilePicture();

      // create a new user instance for provider package
      User user = User(
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        profilePicture: profilePic['profile_pic'],
      );

      // set user details in provider so you can make use of it on the frontend
      log('Setting user details in provider package');
      _userProvider.setUser(user);

      // cache user data
      await _userSharedPreferences.cacheUserDetails(
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        profilePicture: profilePic['profile_pic'],
      );

      // set user details in cache
      log('Getting user details in shared preferences cache');
      _cachedUserData = await _userSharedPreferences.getCachedUserData();
      log('(LoadingData) Cached user data -- $_cachedUserData');

      // check if user provider works
      log('(LoadingData) User Provider Testing -- ${_userProvider.user!.profilePicture}');

      // rebuild wodget tree after data has been loaded and cached
    } else if (data == 'Connection timed out') {
      log('Error -- User Data from gotten user details (LoadingData) -- $data');
    }
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: getDetails(),
      future: _getUserDetails(),
      builder: (context, snapshot) {
        log('(LoadingData) Snapshot connection state -- ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            log('(LoadingData) Snapshot error -- ${snapshot.error}');
            return Center(child: ErrorLoadingScreen());
          } else {
            final user = _userProvider.user;

            return user == null
                ? Center(child: LoadingScreen(color: kOrangeColor))
                : BottomNavBar();
          }
        } else {
          return Center(child: ConnectingScreen(color: kOrangeColor));
        }
      },
    );
  }
}
