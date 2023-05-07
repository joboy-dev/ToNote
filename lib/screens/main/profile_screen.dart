// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/screens/main/dialog_screens/logout_dialog.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

import '../../services/shared_preferences/user_shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String id = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();
  final UserProvider _userProvider = UserProvider();
  Map<String, dynamic> _userData = {};

  Future<Map<String, dynamic>> _getCachedData() async {
    // get user cached data
    Map<String, dynamic> _cachedData =
        await _userSharedPreferences.getCachedUserData();

    log('(ProfileScreen) Cached User Data -- $_cachedData');

    User user = User(
      firstName: _cachedData['first_name'],
      lastName: _cachedData['last_name'],
      email: _cachedData['email'],
      profilePicture: _cachedData['profile_pic'],
    );

    _userProvider.setUser(user);

    // Testing provider
    log('User provider test -- ${_userProvider.user!.firstName}');

    return _cachedData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCachedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            log('Snapshot Error -- ${snapshot.error}');

            return ErrorLoadingScreen();
          } else {
            // get user details from provider
            final user = _userProvider.user;

            return Scaffold(
              backgroundColor: kBgColor,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: kAppPadding,
                    child: user == null
                        ? LoadingScreen(color: kDarkYellowColor)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Profile picture container
                              Center(
                                child: CircleAvatar(
                                  backgroundColor:
                                      kDarkYellowColor.withOpacity(0.5),
                                  foregroundImage:
                                      NetworkImage(user.profilePicture),
                                  radius: 70.0,
                                ),
                              ),
                              SizedBox(height: 20.0),

                              // USER DETAILS
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${user.firstName}, ${user.lastName}',
                                        style: kNormalTextStyle),
                                    SizedBox(height: 10.0),
                                    Text(
                                      user.email,
                                      style: kGreyNormalTextStyle,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10.0),
                              Divider(thickness: 0.35, color: kDarkYellowColor),
                              SizedBox(height: 10.0),

                              // ACCOUNT SETTINGS
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.settings, color: kDarkYellowColor),
                                  SizedBox(width: 10.0),
                                  Text(
                                    'Account Settings',
                                    style: kOtherAppBarTextStyle.copyWith(
                                      color: kGreyTextColor,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(),
                              Divider(),
                              SizedBox(height: 10.0),

                              IconTextButton(
                                text: 'Edit Profile',
                                icon: FontAwesomeIcons.pencil,
                                iconColor: kDarkYellowColor,
                                onPressed: () {},
                              ),
                              SizedBox(height: 20.0),

                              IconTextButton(
                                text: 'Change Profile Picture',
                                icon: Icons.camera_rounded,
                                iconColor: kDarkYellowColor,
                                onPressed: () {
                                  navigatorPushNamed(
                                      context, AddProfilePicture.id);
                                },
                              ),
                              SizedBox(height: 20.0),

                              IconTextButton(
                                text: 'Change Password',
                                icon: FontAwesomeIcons.lock,
                                iconColor: kDarkYellowColor,
                                onPressed: () {},
                              ),
                              SizedBox(height: 20.0),

                              SizedBox(height: 20.0),

                              // Logout button
                              Button(
                                buttonText: 'Logout',
                                onPressed: () {
                                  showDialogBox(
                                      context: context, screen: LogoutDialog());
                                },
                                buttonColor: kRedColor,
                                inactive: false,
                              )
                            ],
                          ),
                  ),
                ),
              ),
            );
          }
        } else {
          return LoadingScreen(color: kDarkYellowColor);
        }
      },
    );
  }
}
