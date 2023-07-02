// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/services/timer.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key, this.color});

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  Loader(size: 40.0, color: color),
                  SizedBox(height: 10.0),
                  Text(
                    // _loadingTimer.isLoading
                    // ?
                    'Fetching data',
                    // : _loadingTimer.message,
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingScreenNoScaffold extends StatelessWidget {
  LoadingScreenNoScaffold({super.key, this.color});

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.35),
        Loader(size: 40.0, color: color),
        SizedBox(height: 10.0),
        Text(
          // _loadingTimer.isLoading
          // ?
          'Fetching data',
          // : _loadingTimer.message,
          style: kGreyNormalTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ErrorLoadingScreen extends StatelessWidget {
  ErrorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  Icon(
                    Icons.warning,
                    size: 40.0,
                    color: kRedColor,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'We could not fetch your data at this time. Please check your network connection or try again later.',
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: IconTextButton(
                      icon: Icons.refresh,
                      iconColor: kOrangeColor,
                      text: 'Reload',
                      onPressed: () {
                        navigatorPushReplacementNamed(
                            context, LoadingDataScreen.id);
                        // navigatorPushReplacementNamed(context, BottomNavBar.id);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorLoadingScreenNoScaffold extends StatelessWidget {
  ErrorLoadingScreenNoScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.30),
        Icon(
          Icons.warning,
          size: 40.0,
          color: kRedColor,
        ),
        SizedBox(height: 10.0),
        Text(
          'We could not fetch your data at this time. Please check your network connection or try again later.',
          style: kGreyNormalTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Center(
          child: IconTextButton(
            icon: Icons.refresh,
            iconColor: kOrangeColor,
            text: 'Reload',
            onPressed: () {
              navigatorPushReplacementNamed(context, LoadingDataScreen.id);
              // navigatorPushReplacementNamed(context, BottomNavBar.id);
            },
          ),
        )
      ],
    );
  }
}

class ConnectingScreen extends StatelessWidget {
  ConnectingScreen({super.key, required this.color});

  Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  Loader(size: 40.0, color: color),
                  SizedBox(height: 10.0),
                  Text(
                    'Connecting...',
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
