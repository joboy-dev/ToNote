import 'package:flutter/material.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
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
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: kHeightWidth(context).height * 0.35),
                  Loader(size: 40.0, color: color),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Fetching data',
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
  const LoadingScreenNoScaffold({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.35),
        Loader(size: 40.0, color: color),
        const SizedBox(height: 10.0),
        const Text(
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
  const ErrorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  const Icon(
                    Icons.warning,
                    size: 40.0,
                    color: kRedColor,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'We could not fetch your data at this time. Please check your network connection or try again later.',
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
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
        const Icon(
          Icons.warning,
          size: 40.0,
          color: kRedColor,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'We could not fetch your data at this time. Please check your network connection or try again later.',
          style: kGreyNormalTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
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
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  Loader(size: 40.0, color: color),
                  const SizedBox(height: 10.0),
                  const Text(
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
