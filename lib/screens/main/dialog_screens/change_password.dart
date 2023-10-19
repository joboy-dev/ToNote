import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';
// import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

import '../../../shared/widgets/button.dart';

class ChangePassword extends StatefulWidget {
  final User? user;
  const ChangePassword({super.key, this.user});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String oldPword = '';
  String newPword = '';
  String newPword2 = '';
  String? email;
  String message = '';
  bool inactiveButton = true;
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final UserView _userView = UserView();

  // final IsarService _isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    validateForm() async {
      if (_formKey.currentState!.validate()) {
        if (newPword == newPword2) {
          if (oldPword != newPword) {
            setState(() {
              _isLoading = true;
            });

            var data = await _userView.changePassword(
                email: '${user?.email}',
                olaPassword: oldPword,
                newPassword: newPword,
                confirmPassword: newPword2);

            setState(() {
              _isLoading = false;
            });

            if (data is Map) {
              setState(() {
                message = 'Successfully updated password';
                navigatorPop(context);
                showSnackbar(context, message);
              });
            } else if (data == 400) {
              setState(() {
                message = 'Old password incorrect. Try again';
              });
            } else {
              setState(() {
                message = 'Something went wrong. Try again';
              });
            }
          } else {
            setState(() {
              message = 'Your old and new password cannot be the same';
            });
          }
        } else {
          setState(() {
            message = 'Your new password doesn\'t metch. Try again.';
          });
        }
      }
    }

    return user == null
        ? const LoadingScreen(color: kDarkYellowColor)
        : Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                const DialogHeader(
                  headerText: 'Change Password',
                  mainColor: kDarkYellowColor,
                  icon: FontAwesomeIcons.lock,
                ),

                // Email field
                EmailTextField(
                  initialValue: user.email,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  readOnly: true,
                  color: kDarkYellowColor,
                ),
                const SizedBox(height: 10.0),

                // Password field
                PasswordTextField(
                  hintText: 'Enter old password',
                  obscureText: _obscureText,
                  onChanged: (value) {
                    setState(() {
                      oldPword = '$value';
                    });
                  },
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  color: kDarkYellowColor,
                ),
                const SizedBox(height: 10.0),

                // Password field
                PasswordTextField(
                  hintText: 'Enter new password',
                  obscureText: _obscureText1,
                  onChanged: (value) {
                    setState(() {
                      newPword = '$value';
                    });
                  },
                  onTap: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                  color: kDarkYellowColor,
                ),

                const SizedBox(height: 10.0),

                // Password field
                PasswordTextField(
                  hintText: 'Confirm new password',
                  obscureText: _obscureText2,
                  onChanged: (value) {
                    setState(() {
                      newPword2 = '$value';
                    });
                  },
                  onTap: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                  color: kDarkYellowColor,
                ),
                const SizedBox(height: 10.0),

                DoubleButton(
                  button2Color: kDarkYellowColor,
                  button2Text: 'Save',
                  inactiveButton: false,
                  button2onPressed: () async {
                    await validateForm();
                  },
                ),

                const SizedBox(height: 10.0),

                _isLoading
                    ? const Loader(size: 20.0, color: kDarkYellowColor)
                    : const SizedBox(height: 0.0),

                message.isEmpty
                    ? const SizedBox(height: 0.0)
                    : Center(
                      child: Text(
                          message,
                          style: kNormalTextStyle.copyWith(color: kRedColor),
                        ),
                    ),
              ],
            ),
          );
  }
}
