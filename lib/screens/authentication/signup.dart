// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool inactiveButton = true;

  String message = '';

  String fName = '';
  String lName = '';
  String email = '';
  String pword = '';
  String pword2 = '';

  // initialize user api class
  final UserView _userView = UserView();

  bool _isLoading = false;

  // function to validate the form fields
  validateForm() async {
    final UserModel _newUser = UserModel(
      firstName: fName,
      lastName: lName,
      email: email,
      password: pword,
      password2: pword2,
    );

    if (pword == pword2) {
      if (_formKey.currentState!.validate()) {
        // activate loading
        setState(() {
          _isLoading = true;
        });

        // create user account and store return value in a variable
        var data = await _userView.createAccount(user: _newUser);
        log('(Signup Screen) User Data -- $data');

        // deactivate loading
        setState(() {
          _isLoading = false;
        });

        // check for exception
        if (data == 400) {
          setState(() {
            message =
                'User with this email already exists. Try using another email.';
          });
        } else if (data is User) {
          // await IsarService().saveUser(context, data);

          setState(() {
            message = 'Account created successfully. Login.';
          });
          navigatorPushReplacement(context, const Login());
        } else {
          setState(() {
            message =
                'Your request could not be processed at this time. Please, try again later.';
          });
        }
        showSnackbar(context, message);
      }
    } else {
      // deactivate loading
      setState(() {
        _isLoading = false;
      });

      message = 'Your passwords do not match. Try again';
      showSnackbar(context, message);
    }
  }

  // check if all form fields are not empty so as to update button state accordingly
  updateButtonState() {
    setState(() {
      inactiveButton = fName.isEmpty ||
          lName.isEmpty ||
          email.isEmpty ||
          pword.isEmpty ||
          pword2.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBgColor(context),
        surfaceTintColor: kScaffoldBgColor(context),
        elevation: 0.0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        title: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              'Create Account',
              style: kAppBarTextStyle().copyWith(
                color: kTextTheme(context),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Column(
              children: [
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: const Image(
                    image: AssetImage('assets/images/signup.png'),
                    fit: BoxFit.cover,
                  ),
                ).animate(
                  effects: MyEffects.fadeSlide()
                  ),
                SizedBox(height: 30.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // FIrst Name
                          Expanded(
                            child: NameTextField(
                              hintText: 'First Name',
                              onChanged: (value) {
                                setState(() {
                                  fName = value!;
                                  updateButtonState();
                                });
                              },
                            ),
                          ),

                          // Last Name
                          Expanded(
                            child: NameTextField(
                              hintText: 'Last Name',
                              onChanged: (value) {
                                lName = value!;
                                updateButtonState();
                              },
                            ),
                          ),
                        ],
                      ),

                      // Email
                      EmailTextField(
                        onChanged: (value) {
                          setState(() {
                            email = value!;
                            updateButtonState();
                          });
                        },
                      ),

                      // Password
                      PasswordTextField(
                        hintText: 'Password',
                        obscureText: obscureText1,
                        onChanged: (value) {
                          setState(() {
                            pword = value!;
                            updateButtonState();
                          });
                        },
                        onTap: () {
                          setState(() {
                            obscureText1 = obscureText1 ? false : true;
                          });
                        },
                      ),

                      // Confirm Password
                      PasswordTextField(
                        hintText: 'Confirm Password',
                        obscureText: obscureText2,
                        onChanged: (value) {
                          setState(() {
                            pword2 = value!;
                            updateButtonState();
                          });
                        },
                        onTap: () {
                          setState(() {
                            obscureText2 = obscureText2 ? false : true;
                          });
                        },
                      ),

                      // Button
                      _isLoading
                          ? Loader(size: 30.r)
                          : Button(
                              buttonText: 'Create Account',
                              onPressed: () {
                                inactiveButton ? null : validateForm();
                              },
                              buttonColor: kGreenColor,
                              inactive: inactiveButton,
                            ),
                      SizedBox(height: 10.h),

                      ButtonText(
                        firstText: 'Already have an account? ',
                        secondText: 'Login',
                        onTap: () {
                          navigatorPushReplacement(context, const Login());
                        },
                      ),
                    ].animate(
                      delay: kAnimationDurationMs(500),
                      interval: kAnimationDurationMs(50),
                      effects: MyEffects.fadeSlide()
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
