// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/user_provider.dart';

import 'package:todoey/screens/main/dialog_screens/upload_profile_picture.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({super.key});

  static const String id = 'addprofilepic';

  @override
  State<AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture>
    with TickerProviderStateMixin {
  // instantiate ImagePicker
  final ImagePicker _imagePicker = ImagePicker();

  // File _image = File('asstes/images/default.jpg');
  File? _image;

  // ANIMATION
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller2 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

    _controller3 =
        AnimationController(vsync: this, duration: kAnimationDuration1);

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
    final user = Provider.of<UserProvider?>(context)?.user;

    // function to select image from gallery
    Future selectImageFromGallery() async {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (_image != null) {
        // set image to selected image
        setState(() {
          // convert XFile into a File object
          _image = File(image!.path);
          log('$_image');
        });

        showDialogBox(
          context: context,
          dismisible: false,
          screen: UploadProfilePicture(
            image: _image ?? user?.profilePicture,
          ),
        );
      }
    }

    // functio n to select image through camera
    Future selectImageFromCamera() async {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);

      if (_image != null) {
        // set image to selected image
        setState(() {
          // convert XFile into a File object
          _image = File(image!.path);
          log('$_image');
        });

        showDialogBox(
          context: context,
          dismisible: false,
          screen: UploadProfilePicture(
            image: _image ?? user?.profilePicture,
          ),
        );
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: kBgColor,
      //   elevation: 0.0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(10.0),
      //       bottomRight: Radius.circular(10.0),
      //     ),
      //   ),
      //   iconTheme: IconThemeData(color: kTextColor),
      // ),
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FadeTransition(
                  opacity: _animation1,
                  child: Text(
                    'Add your profile picture.\n\nIf you do not want to perform this action, you can click the skip button below.',
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 20.0),
                FadeTransition(
                  opacity: _animation2,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialogBox(
                          context: context,
                          dismisible: false,
                          screen: UploadProfilePicture(image: _image!),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: kGreyTextColor,
                        backgroundImage:
                            AssetImage('assets/images/default.jpg'),
                        foregroundImage:
                            NetworkImage('${user?.profilePicture}'),
                        radius: 120.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                FadeTransition(
                  opacity: _animation2,
                  child: Text(
                    'Select from the two options below on how you want to add your profile picture.',
                    style: kGreyNormalTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 30.0),

                // Buttons
                SlideTransition(
                  position: slideTransitionAnimation(
                      dx: 2, dy: 0, animation: _animation3),
                  child: FadeTransition(
                    opacity: _animation3,
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonIcon(
                            buttonText: 'Gallery',
                            onPressed: () {
                              selectImageFromGallery();
                            },
                            buttonColor: kYellowColor,
                            icon: Icons.photo_library,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: ButtonIcon(
                            buttonText: 'Camera',
                            onPressed: () {
                              selectImageFromCamera();
                            },
                            buttonColor: kGreenColor,
                            icon: FontAwesomeIcons.camera,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.0),

                // Skip button
                // TextButton(
                //   onPressed: () {
                //     navigatorPushReplacementNamed(context, Login.id);
                //   },
                //   style: TextButton.styleFrom(),
                //   child: Text(
                //     'Skip>>',
                //     style: kNormalTextStyle.copyWith(
                //       color: kDarkYellowColor,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
