// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todoey/backend/user/user_view.dart';
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
      showSnackbar(context, message);
      navigatorPushReplacementNamed(context, Wrapper.id);
    } else {
      setState(() {
        message = 'An error occured while signing you out. Try again .';
      });
      // navigatorPop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          button2onPressed: () async {
            // clear the isar database
            await IsarService().clearDb(context);
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
        message.isEmpty
            ? SizedBox(height: 0.0)
            : Center(
                child: Text(
                  message,
                  style: kNormalTextStyle.copyWith(color: kRedColor),
                ),
              ),
      ],
    );
  }
}
