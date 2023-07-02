// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.textColor,
    this.appBarText,
    this.otherAppBarText,
    this.height = kToolbarHeight,
    this.imageUrl,
  });

  Color textColor;
  String? appBarText;
  String? otherAppBarText;
  double height;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0.0,
      title: otherAppBarText == null
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    appBarText ?? 'greeting, {user.firstName}',
                    style: kOtherAppBarTextStyle.copyWith(
                      color: textColor,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                    backgroundColor: textColor.withOpacity(0.5),
                    foregroundImage: imageUrl == null
                        ? AssetImage('assets/images/default.jpg')
                        : NetworkImage(imageUrl!) as ImageProvider,
                  ),
                ),
              ],
            )
          : Text(
              otherAppBarText!,
              style: kOtherAppBarTextStyle.copyWith(
                color: textColor,
                fontSize: 17.0,
              ),
            ),
      elevation: 0,
      centerTitle: false,
      foregroundColor: kBgColor,
      backgroundColor: kBgColor,
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => Size.fromHeight(height);
}
