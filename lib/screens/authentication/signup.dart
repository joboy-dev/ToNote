// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const String id = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  validateForm() {
    if (pword == pword2) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          message = 'Successfully signed up';
        });
      } else {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    
    // _formKey.currentState?.
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
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/signup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.0),
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
                                  fName = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10.0),

                          // Last Name
                          Expanded(
                            child: NameTextField(
                              hintText: 'Last Name',
                              onChanged: (value) {
                                lName = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),

                      // Email
                      EmailTextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),

                      // Password
                      PasswordTextField(
                        hintText: 'Password',
                        obscureText: obscureText1,
                        onChanged: (value) {
                          setState(() {
                            pword = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            obscureText1 = obscureText1 ? false : true;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),

                      // Confirm Password
                      PasswordTextField(
                        hintText: 'Confirm Password',
                        obscureText: obscureText2,
                        onChanged: (value) {
                          setState(() {
                            pword2 = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            obscureText2 = obscureText2 ? false : true;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),

                      // Button
                      Button(
                        buttonText: 'Creste Account',
                        onPressed: () {
                          inactiveButton ? null : validateForm();
                        },
                        buttonColor:
                            inactiveButton ? kInactiveColor : kGreenColor,
                        inactive: inactiveButton,
                      )
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
