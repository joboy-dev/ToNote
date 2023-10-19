// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/provider/device_prefs_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/edit_profile.dart';
import 'package:todoey/screens/main/dialog_screens/logout_dialog.dart';
import 'package:todoey/services/user_preferences.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

import 'dialog_screens/change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String id = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    kDarkMode = Provider.of<DevicePrefsProvider>(context).darkMode;
    // kDarkMode = Prefs().isDarkMode();
    log('ProfileScreen dark mode constant $kDarkMode');

    toggleTheme() async {
      await Prefs().setDarkMode(context, value: !kDarkMode);

      showSnackbar(context, 'Theme updated.');
    }

    log('$kDarkMode');
    return user == null
        ? ErrorLoadingScreen()
        : Scaffold(
            backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kAppPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: IconTextButton(
                              text: 'Logout',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              icon: Icons.logout_rounded,
                              iconColor: kRedColor,
                              textColor: kRedColor,
                              onPressed: () {
                                showDialogBox(
                                  context: context,
                                  screen: LogoutDialog(),
                                  dismisible: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),

                      // Profile picture container
                      // Center(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showDialogBox(
                      //         context: context,
                      //         screen: ViewProfilePictureScreen(),
                      //       );
                      //     },
                      //     child: CircleAvatar(
                      //       backgroundColor: kDarkYellowColor.withOpacity(0.5),
                      //       foregroundImage:
                      //           NetworkImage('${user.profilePicture}'),
                      //       radius: 70.0,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20.0),

                      // USER DETAILS
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${user.firstName}, ${user.lastName}',
                              style: kGreyNormalTextStyle.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '${user.email}',
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

                      // SizedBox(),
                      Divider(color: kGreyTextColor, thickness: 0.1),
                      SizedBox(height: 10.0),

                      IconTextButton(
                        text: 'Edit Profile',
                        icon: FontAwesomeIcons.pencil,
                        iconColor: kDarkYellowColor,
                        onPressed: () {
                          showDialogBox(
                            context: context,
                            screen: EditProfile(),
                            dismisible: false,
                          );
                        },
                      ),
                      SizedBox(height: 20.0),

                      // IconTextButton(
                      //   text: 'Change Profile Picture',
                      //   icon: Icons.camera_rounded,
                      //   iconColor: kDarkYellowColor,
                      //   onPressed: () {
                      //     navigatorPushNamed(context, AddProfilePicture.id);
                      //   },
                      // ),
                      // SizedBox(height: 20.0),

                      IconTextButton(
                        text: 'Change Password',
                        icon: FontAwesomeIcons.lock,
                        iconColor: kDarkYellowColor,
                        onPressed: () {
                          showDialogBox(
                              context: context, screen: ChangePassword());
                        },
                      ),
                      SizedBox(height: 10.0),

                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: IconTextButton(
                              text: kDarkMode
                                  ? 'Switch to light mode'
                                  : 'Switch to dark mode',
                              icon: kDarkMode
                                  ? Icons.brightness_high_rounded
                                  : FontAwesomeIcons.moon,
                              iconColor: kDarkYellowColor,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Switch.adaptive(
                              activeColor: kDarkYellowColor,
                              activeTrackColor:
                                  kDarkYellowColor.withOpacity(0.5),
                              inactiveThumbColor:
                                  kDarkYellowColor.withOpacity(0.5),
                              inactiveTrackColor: kDarkYellowColor,
                              value: kDarkMode,
                              onChanged: (value) async {
                                await toggleTheme();
                                setState(() {
                                  kDarkMode = value;
                                  kBgColor = kDarkMode
                                      ? Color(0xff1E1E1E)
                                      : Color.fromARGB(255, 250, 250, 250);
                                });
                                log('ProfileScreen switch Dark Mode - $kDarkMode');

                                var todos = await TodoView().getUserTodos();
                                log('User todos-- $todos');
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
