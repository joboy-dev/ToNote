import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: kHeightWidth(context).height * 0.35),
                  Loader(size: 40.r, color: color),
                  SizedBox(height: 10.h),
                  Text(
                    'Fetching data',
                    style: kGreyNormalTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                ].animate(
                  interval: kAnimationDurationMs(500),
                  effects: MyEffects.fadeSlide(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingScreenNoScaffold extends StatelessWidget {
  const LoadingScreenNoScaffold({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.35),
        Loader(size: 40.r, color: color),
        SizedBox(height: 10.h),
        Text(
          // _loadingTimer.isLoading
          // ?
          'Fetching data',
          // : _loadingTimer.message,
          style: kGreyNormalTextStyle(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ErrorLoadingScreen extends StatelessWidget {
  const ErrorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  Icon(
                    Icons.warning,
                    size: 40.r,
                    color: kRedColor,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'We could not fetch your data at this time. Please check your network connection or try again later.',
                    style: kGreyNormalTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
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
  const ErrorLoadingScreenNoScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.30),
        Icon(
          Icons.warning,
          size: 40.r,
          color: kRedColor,
        ),
        SizedBox(height: 10.h),
        Text(
          'We could not fetch your data at this time. Please check your network connection or try again later.',
          style: kGreyNormalTextStyle(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
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
  const ConnectingScreen({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  Loader(size: 40.r, color: color),
                  SizedBox(height: 10.h),
                  Text(
                    'Connecting...',
                    style: kGreyNormalTextStyle(context),
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
