// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoey/backend/user/user_api.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/bottom_navbar.dart';
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

  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _controller1;
  late Animation<double> _animation1;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration3,
    );

    _controller1 = AnimationController(
      vsync: this,
      duration: kAnimationDuration1,
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: kAnimationDuration1,
    );

    // handle all animations one by one
    _controller.forward().whenCompleteOrCancel(() {
      _controller1.forward().whenCompleteOrCancel(() {
        _controller2.forward();
      });
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    ));

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.linearToEaseOut,
    ));

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.linear,
    ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();

    super.dispose();
  }

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
        } else if (data == 201) {
          setState(() {
            message = 'Account created successfully. Login now.';
          });
          navigatorPushNamed(context, Login.id);
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
        backgroundColor: kBgColor,
        elevation: 2.0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        title: Column(
          children: [
            SizedBox(height: 30.0),
            Text(
              'CREATE ACCOUNT',
              style: kAppBarTextStyle,
            ),
            SizedBox(height: 30.0),
          ],
        ),
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              children: [
                SlideTransition(
                  position: slideTransitionAnimation(
                    dx: 0,
                    dy: -2,
                    animation: _animation,
                  ),
                  child: SizedBox(
                    height: 250.0,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/signup.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // FIrst Name
                          Expanded(
                            child: SlideTransition(
                              position: slideTransitionAnimation(
                                dx: -2,
                                dy: 0,
                                animation: _animation1,
                              ),
                              child: NameTextField(
                                hintText: 'First Name',
                                onChanged: (value) {
                                  setState(() {
                                    fName = value;
                                    updateButtonState();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),

                          // Last Name
                          Expanded(
                            child: SlideTransition(
                              position: slideTransitionAnimation(
                                dx: 2,
                                dy: 0,
                                animation: _animation1,
                              ),
                              child: NameTextField(
                                hintText: 'Last Name',
                                onChanged: (value) {
                                  lName = value;
                                  updateButtonState();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),

                      // Email
                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: 2,
                          dy: 0,
                          animation: _animation1,
                        ),
                        child: EmailTextField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              updateButtonState();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // Password
                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: -2,
                          dy: 0,
                          animation: _animation1,
                        ),
                        child: PasswordTextField(
                          hintText: 'Password',
                          obscureText: obscureText1,
                          onChanged: (value) {
                            setState(() {
                              pword = value;
                              updateButtonState();
                            });
                          },
                          onTap: () {
                            setState(() {
                              obscureText1 = obscureText1 ? false : true;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // Confirm Password
                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: 2,
                          dy: 0,
                          animation: _animation1,
                        ),
                        child: PasswordTextField(
                          hintText: 'Confirm Password',
                          obscureText: obscureText2,
                          onChanged: (value) {
                            setState(() {
                              pword2 = value;
                              updateButtonState();
                            });
                          },
                          onTap: () {
                            setState(() {
                              obscureText2 = obscureText2 ? false : true;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Button
                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: 0,
                          dy: 3,
                          animation: _animation2,
                        ),
                        child: _isLoading
                            ? Loader(size: 30.0)
                            : Button(
                                buttonText: 'Create Account',
                                onPressed: () {
                                  inactiveButton ? null : validateForm();
                                },
                                buttonColor: kGreenColor,
                                inactive: inactiveButton,
                              ),
                      ),
                      SizedBox(height: 10.0),

                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: 0,
                          dy: 5,
                          animation: _animation2,
                        ),
                        child: ButtonText(
                          firstText: 'Already have an account? ',
                          secondText: 'Login',
                          onTap: () {
                            navigatorPushReplacementNamed(context, Login.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
