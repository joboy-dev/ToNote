// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/screens/main/dialog_screens/logout_dialog.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Text(
                  'My Profile',
                  style: kAppBarTextStyle.copyWith(color: kDarkYellowColor),
                ),
                SizedBox(height: 5.0),
                Divider(thickness: 0.5),
                SizedBox(height: 10.0),

                // Profile picture container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: kDarkYellowColor.withOpacity(0.5),
                        radius: 70.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigatorPushNamed(context, AddProfilePicture.id);
                      },
                      child: Icon(
                        FontAwesomeIcons.pencil,
                        color: kDarkYellowColor,
                        size: 15.0,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),

                // USER DETAILS
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Last name, First name', style: kNormalTextStyle),
                      SizedBox(height: 10.0),
                      Text('Email', style: kGreyNormalTextStyle),
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

                IconTextButton(
                  text: 'Edit Profile',
                  icon: FontAwesomeIcons.pencil,
                  iconColor: kDarkYellowColor,
                  onPressed: () {},
                ),

                IconTextButton(
                  text: 'Edit Profile',
                  icon: FontAwesomeIcons.pencil,
                  iconColor: kDarkYellowColor,
                  onPressed: () {},
                ),

                SizedBox(height: 20.0),

                // Logout button
                Button(
                  buttonText: 'Logout',
                  onPressed: () {
                    showDialogBox(context: context, screen: LogoutDialog());
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
}
