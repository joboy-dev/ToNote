// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool inactiveButton = true;

  String message = '';

  String email = '';
  String pword = '';

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

  final UserView _userView = UserView();
  bool _isLoading = false;

  // function to validate the form fields
  validateForm() async {
    if (_formKey.currentState!.validate()) {
      // set loading to true
      setState(() {
        _isLoading = true;
      });

      // login function
      var data = await _userView.login(email: email, password: pword);

      // set loading to false after login is complete
      setState(() {
        _isLoading = false;
      });

      // check for errors
      if (data == 200) {
        setState(() {
          message = 'Welcome $email.';
        });
        navigatorPushReplacementNamed(context, BottomNavBar.id);
      } else if (data == 400) {
        setState(() {
          message =
              'Your credentials are incorrect. Check your email and password.';
        });
      } else {
        setState(() {
          message =
              'Your request could not be processed at this time. Please, try again later.';
        });
      }
      showSnackbar(context, message);
    }
  }

  // check if all formfields are not empty so as to update button state accordingly
  updateButtonState() {
    setState(() {
      inactiveButton = email.isEmpty || pword.isEmpty;
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
              'LOGIN',
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
                      image: AssetImage('assets/images/login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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

                      SizedBox(height: 20.0),

                      // Button
                      SlideTransition(
                        position: slideTransitionAnimation(
                          dx: -2,
                          dy: 0,
                          animation: _animation2,
                        ),
                        child: _isLoading
                            ? Loader(size: 30.0)
                            : Button(
                                buttonText: 'Login',
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
                          dx: 2,
                          dy: 0,
                          animation: _animation2,
                        ),
                        child: ButtonText(
                          firstText: 'Don\'t have an account? ',
                          secondText: 'Sign up',
                          onTap: () {
                            navigatorPushReplacementNamed(context, SignUp.id);
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
