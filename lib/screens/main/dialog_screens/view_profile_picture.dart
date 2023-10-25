import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';

class ViewProfilePictureScreen extends StatelessWidget {
  const ViewProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    return Column(
      children: [
        const DialogHeader(
          headerText: 'Profile Picture',
          mainColor: kDarkYellowColor,
          icon: FontAwesomeIcons.image,
        ),
        Container(
          height: 270.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            image: DecorationImage(
              image: NetworkImage('${user?.profilePicture}'),
            ),
          ),
        ),
        Text(
          'Tap outside to dismiss.',
          style: kGreyNormalTextStyle(context),
        ),
      ],
    );
  }
}
