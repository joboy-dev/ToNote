// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';
import 'package:todoey/wrapper.dart';

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

  final UserView _userView = UserView();
  final IsarService _isarService = IsarService();
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
      if (data is Map) {
        setState(() {
          _isLoading = true;
        });

        var userData = await _userView.getUserDetails();
        // var userPic = await _userView.getUserProfilePicture();

        if (userData is User) {
          // Save user datails to iser service
          await _isarService.saveUser(context, userData);

          setState(() {
            _isLoading = false;
            message = 'Welcome $email.';
          });
          navigatorPushReplacement(context, const Wrapper());
        } else {
          setState(() {
            _isLoading = false;
            message = 'Something went wrong. Try again.';
          });
        }
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
        backgroundColor: kScaffoldBgColor(context),
        surfaceTintColor: kScaffoldBgColor(context),
        elevation: 0.0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        title: Column(
          children: [
            const SizedBox(height: 30.0),
            Text(
              'Login',
              style: kAppBarTextStyle,
            ),
            // Divider(),
            const SizedBox(height: 30.0),
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
                SizedBox(
                  height: kHeightWidth(context).height * 0.35,
                  width: double.infinity,
                  child: const Image(
                    image: AssetImage('assets/images/login.png'),
                    fit: BoxFit.cover,
                  ),
                ).animate(
                    effects: MyEffects.fadeSlide()
                  ),
                const SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      EmailTextField(
                        onChanged: (value) {
                          setState(() {
                            email = value!;
                            updateButtonState();
                          });
                        },
                      ),
                      const SizedBox(height: 10.0),

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

                      const SizedBox(height: 20.0),

                      // Button
                      _isLoading
                          ? const Loader(size: 30.0)
                          : Button(
                              buttonText: 'Login',
                              onPressed: () {
                                inactiveButton ? null : validateForm();
                              },
                              buttonColor: kGreenColor,
                              inactive: inactiveButton,
                            ),

                      const SizedBox(height: 10.0),

                      ButtonText(
                        firstText: 'Don\'t have an account? ',
                        secondText: 'Sign up',
                        onTap: () {
                          navigatorPushReplacement(context, const SignUp());
                        },
                      ),
                    ].animate(
                      delay: kAnimationDurationMs(500),
                      interval: kAnimationDurationMs(50),
                      effects: MyEffects.fadeSlide()
                    ),
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
