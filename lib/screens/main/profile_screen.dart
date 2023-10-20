// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/provider/device_prefs_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/edit_profile.dart';
import 'package:todoey/screens/main/dialog_screens/logout_dialog.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

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
    // read from the provider
    final themeSwitch = context.read<DevicePrefsProvider>();
    // watch value in privider
    bool theme = context.watch<DevicePrefsProvider>().isDarkMode;
    log('ProfileScreen dark mode constant $kDarkMode');


    log('$kDarkMode');
    return user == null
        ? const ErrorLoadingScreen()
        : Scaffold(
            // backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kAppPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20.0),

                      // USER DETAILS
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.firstName}, ${user.lastName}',
                            style: kGreyNormalTextStyle.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '${user.email}',
                            style: kGreyNormalTextStyle,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10.0),
                      const Divider(thickness: 0.35, color: kDarkYellowColor),
                      const SizedBox(height: 10.0),

                      // ACCOUNT SETTINGS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.settings, color: kDarkYellowColor),
                          const SizedBox(width: 10.0),
                          Text(
                            'Account Settings',
                            style: kOtherAppBarTextStyle.copyWith(
                              color: kGreyTextColor,
                            ),
                          ),
                        ],
                      ),

                      // SizedBox(),
                      const Divider(color: kGreyTextColor, thickness: 0.1),
                      const SizedBox(height: 10.0),

                      IconTextButton(
                        text: 'Edit Profile',
                        icon: FontAwesomeIcons.pencil,
                        iconColor: kDarkYellowColor,
                        onPressed: () {
                          showDialogBox(
                            context: context,
                            screen: const EditProfile(),
                            dismisible: false,
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),

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
                              context: context, screen: const ChangePassword());
                        },
                      ),
                      const SizedBox(height: 10.0),

                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: IconTextButton(
                              text: theme
                                  ? 'Switch to light mode'
                                  : 'Switch to dark mode',
                              icon: theme
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
                              value: theme,
                              onChanged: (value) async {
                                await themeSwitch.toggleThemeMode();
                                setState(() {
                                  theme = value;
                                  // kBgColor = kDarkMode
                                  //     ? const Color(0xff1E1E1E)
                                  //     : const Color.fromARGB(255, 250, 250, 250);
                                });
                                log('ProfileScreen switch Dark Mode - $kDarkMode');

                                var todos = await TodoView().getUserTodos();
                                log('User todos-- $todos');
                              },
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      // Logout button
                      IconTextButton(
                        text: 'Logout',
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        icon: Icons.logout_rounded,
                        iconColor: kRedColor,
                        textColor: kRedColor,
                        onPressed: () {
                          showDialogBox(
                            context: context,
                            screen: const LogoutDialog(),
                            dismisible: true,
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
