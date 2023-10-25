import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        appBarText ?? 'greeting, {user.firstName}',
                        style: kOtherAppBarTextStyle().copyWith(
                          color: textColor,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 0,
                      child: trailing ?? const SizedBox(),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Divider(
                  color: dividerColor ?? Colors.transparent,
                  thickness: 1.r,
                )
              ],
            )
          : Text(
              otherAppBarText!,
              style: kOtherAppBarTextStyle().copyWith(
                color: textColor,
                fontSize: 17.sp,
              ),
            ),
      elevation: 0,
      centerTitle: false,
      foregroundColor: appBarColor ?? kScaffoldBgColor(context),
      backgroundColor: appBarColor ?? kScaffoldBgColor(context),
      toolbarHeight: height ?? 40.h,
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => Size.fromHeight(height ?? 40.h);
}
