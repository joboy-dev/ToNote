// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';

class UploadProfilePicture extends StatefulWidget {
  UploadProfilePicture({super.key, required this.imageFile});

  File imageFile;

  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller2 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller1.forward().whenCompleteOrCancel(() {
      _controller2.forward();
    });

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(_controller1);
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.easeIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file, color: kYellowColor, size: 30.0),
            SizedBox(width: 10.0),
            Text(
              'Upload Picture',
              style: kOtherAppBarTextStyle.copyWith(color: kYellowColor),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Divider(),
        SizedBox(height: 10.0),

        // imege from file
        Image.file(
          widget.imageFile,
          fit: BoxFit.contain,
          opacity: _animation1,
          width: double.infinity,
          height: 250.0,
        ),

        SizedBox(height: 20.0),

        // upload button
        FadeTransition(
          opacity: _animation2,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Button(
                  buttonText: 'Set Picture',
                  onPressed: () {
                    // TODO: Implement Upload Functionality
                  },
                  buttonColor: kYellowColor,
                  inactive: false,
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: ButtonIcon(
                  buttonText: '',
                  onPressed: () {
                    navigatorPop(context);
                  },
                  buttonColor: kRedColor,
                  icon: Icons.close,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
