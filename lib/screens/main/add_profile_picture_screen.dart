// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({super.key});

  static const String id = 'addprofilepic';

  @override
  State<AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Animation<double> _animation1;
  late Animation _animation2;
  late Animation _animation3;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: kAnimationDuration3);

    _controller2 =
        AnimationController(vsync: this, duration: kAnimationDuration3);

    _controller3 =
        AnimationController(vsync: this, duration: kAnimationDuration3);

    _controller1.forward().whenCompleteOrCancel(() {
      _controller2.forward().whenCompleteOrCancel(() {
        _controller3.forward();
      });
    });

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeIn),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeIn),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
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
              'ADD PROFILE PICTURE',
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Add your profile picture.\n\nIf you do not want to perform this action, you can click the skip button below.',
                  style: kGreyNormalTextStyle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: CircleAvatar(
                    backgroundColor: kGreyTextColor,
                    radius: 60.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Select from the two options below on how you want to add your profile picture.',
                  style: kGreyNormalTextStyle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30.0),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ButtonIcon(
                        buttonText: 'Gallery',
                        onPressed: () {},
                        buttonColor: kYellowColor,
                        icon: Icons.browse_gallery,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: ButtonIcon(
                        buttonText: 'Camera',
                        onPressed: () {},
                        buttonColor: kGreenColor,
                        icon: FontAwesomeIcons.camera,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),

                // Skip button
                TextButton(
                  onPressed: () {
                    navigatorPushReplacementNamed(context, Login.id);
                  },
                  style: TextButton.styleFrom(),
                  child: Text(
                    'Skip>>',
                    style: kNormalTextStyle.copyWith(
                      color: kDarkYellowColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
