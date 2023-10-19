// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.textColor,
    this.appBarText,
    this.otherAppBarText,
    this.height,
    this.imageUrl,
    this.appBarColor,
    this.dividerColor,
    this.trailing,
  });

  Color textColor;
  String? appBarText;
  String? otherAppBarText;
  double? height;
  String? imageUrl;
  Color? appBarColor;
  Color? dividerColor;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0.0,
      title: otherAppBarText == null
          ? Column(
              children: [
                Row(
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
                      child: trailing
                      ??
                          CircleAvatar(
                            backgroundColor: textColor.withOpacity(0.5),
                            foregroundImage: imageUrl == null
                                ? AssetImage('assets/images/default.jpg')
                                : NetworkImage(imageUrl!) as ImageProvider,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Divider(
                  color: dividerColor ?? Colors.transparent,
                  thickness: 1.0,
                )
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
      foregroundColor: appBarColor ?? kBgColor,
      backgroundColor: appBarColor ?? kBgColor,
      toolbarHeight: height ?? kToolbarHeight,
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
