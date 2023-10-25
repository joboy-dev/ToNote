// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

import '../../../shared/widgets/button.dart';

class EditProfile extends StatefulWidget {
  final User? user;
  const EditProfile({super.key, this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String? fName;
  String? lName;
  String? email;
  String message = '';
  bool inactiveButton = true;
  // final _loadingProvider = LoadingProvider();
  bool _isLoading = false;

  final UserView _userView = UserView();

  final IsarService _isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;

    // _isLoading = _loadingProvider.isLoading!;

    validateForm() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        // _loadingProvider.setTrue();

        // update user details on backend
        var data = await _userView.updateUserDetails(
          firstName: fName ?? '${user?.firstName}',
          lastName: lName ?? '${user?.lastName}',
          email: email ?? '${user?.email}',
        );

        setState(() {
          _isLoading = false;
        });

        // _loadingProvider.setFalse();

        if (data is Map) {
          // save updated data to isar
          await _isarService.saveUser(
              context,
              User()
                ..firstName = fName ?? '${user?.firstName}'
                ..lastName = lName ?? '${user?.lastName}'
                ..email = email ?? '${user?.email}'
                ..profilePicture = data['profile_pic']
                ..id = data['id']);
          navigatorPop(context);
          setState(() {
            message = 'Successfully updated profile';
          });
          showSnackbar(context, message);
        } else if (data == 400) {
          setState(() {
            message = 'This email already exists';
          });
        } else {
          setState(() {
            message = 'Something went wrong. Try again';
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
                  headerText: 'Edit Profile',
                  mainColor: kDarkYellowColor,
                  icon: FontAwesomeIcons.pencil,
                ),

                // First name field
                NormalTextField(
                  hintText: 'First Name',
                  initialValue: user.firstName,
                  onChanged: (value) {
                    setState(() {
                      fName = value;
                    });
                  },
                  cursorColor: kDarkYellowColor,
                  enabledBorderColor: kDarkYellowColor,
                  focusedBorderColor: kDarkYellowColor,
                  focusedErrorBorderColor: kRedColor,
                  errorBorderColor: kRedColor,
                  errorTextStyleColor: kRedColor,
                  iconColor: kDarkYellowColor,
                  prefixIcon: Icons.person,
                ),

                // Last name field
                NormalTextField(
                  hintText: 'Last Name',
                  initialValue: user.lastName,
                  onChanged: (value) {
                    setState(() {
                      lName = value;
                    });
                  },
                  cursorColor: kDarkYellowColor,
                  enabledBorderColor: kDarkYellowColor,
                  focusedBorderColor: kDarkYellowColor,
                  focusedErrorBorderColor: kRedColor,
                  errorBorderColor: kRedColor,
                  errorTextStyleColor: kRedColor,
                  iconColor: kDarkYellowColor,
                  prefixIcon: Icons.person,
                ),

                // Email field
                EmailTextField(
                  initialValue: user.email,
                  color: kDarkYellowColor,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),

                DoubleButton(
                  button2Color: kDarkYellowColor,
                  button2Text: 'Save',
                  inactiveButton: false,
                  button2onPressed: () async {
                    await validateForm();
                  },
                ),

                SizedBox(height: 10.h),

                _isLoading
                    ? Loader(size: 20.r, color: kDarkYellowColor)
                    : const SizedBox(height: 0.0),

                message.isEmpty
                    ? const SizedBox(height: 0.0)
                    : Center(
                        child: Text(
                          message,
                          style: kNormalTextStyle().copyWith(color: kRedColor),
                        ),
                      ),
              ].animate(
                delay: kAnimationDurationMs(500),
                interval: kAnimationDurationMs(50),
                effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
              ),
            ),
          );
  }
}
