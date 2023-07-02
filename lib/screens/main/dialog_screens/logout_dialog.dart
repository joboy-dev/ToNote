// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/wrapper.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  final UserView _userView = UserView();
  String message = '';
  bool _isLoading = false;

  _logout() async {
    setState(() {
      _isLoading = true;
    });
    var data = await _userView.logout();
    setState(() {
      _isLoading = false;
    });
    if (data == 200) {
      setState(() {
        message = 'Successfully logged out. See you soon.';
      });
      navigatorPushReplacementNamed(context, GetStarted.id);
    } else {
      setState(() {
        message = 'An error occured while signing you out. Try again .';
      });
      navigatorPop(context);
    }
    showSnackbar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context);
    return Column(
      children: [
        DialogHeader(
          headerText: 'Logout',
          icon: Icons.logout_rounded,
          mainColor: kRedColor,
        ),
        SizedBox(height: 10.0),
        Text('Are you sure you want to log out?', style: kGreyNormalTextStyle),
        SizedBox(height: 20.0),
        DoubleButton(
          inactiveButton: false,
          button2Text: 'Logout',
          button2Color: kDarkYellowColor,
          button2onPressed: () {
            // clear user data from provider
            user?.clearUser();

            // logout
            _logout();
          },
        ),
        SizedBox(height: 10.0),
        _isLoading
            ? Text(
                'Logging out...',
                style: kNormalTextStyle.copyWith(
                  color: kDarkYellowColor,
                  fontSize: 12.0,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
