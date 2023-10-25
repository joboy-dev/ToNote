import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
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

  final Color textColor;
  final String? appBarText;
  final String? otherAppBarText;
  final double? height;
  final String? imageUrl;
  final Color? appBarColor;
  final Color? dividerColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0.0,
      surfaceTintColor: kScaffoldBgColor(context),
      title: otherAppBarText == null
          ? Column(
              children: [
                const SizedBox(height: 40.0),
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
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 0,
                      child: trailing ?? const SizedBox(),
                          // CircleAvatar(
                          //   backgroundColor: textColor.withOpacity(0.5),
                          //   foregroundImage: imageUrl == null
                          //       ? const AssetImage('assets/images/default.jpg')
                          //       : NetworkImage(imageUrl!) as ImageProvider,
                          // ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
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
      foregroundColor: appBarColor ?? kScaffoldBgColor(context),
      backgroundColor: appBarColor ?? kScaffoldBgColor(context),
      toolbarHeight: height ?? kToolbarHeight,
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
