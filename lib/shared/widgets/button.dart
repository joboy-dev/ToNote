import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final bool inactive;

  const Button({
    super.key, 
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.inactive,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50.h,
      color: inactive ? kInactiveColor : buttonColor,
      focusColor: inactive
          ? kInactiveColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      elevation: inactive ? 1.0 : 2.0,
      focusElevation: inactive ? 1.0 : 4.0,
      splashColor: inactive
          ? kInactiveColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: kButtonTextColor,
          fontSize: 15.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final IconData icon;

  const ButtonIcon({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50.h,
      color: buttonColor,
      focusColor: buttonColor.withOpacity(0.5),
      elevation: 2.0,
      focusElevation: 4.0,
      splashColor: buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              size: 20.r,
              color: kWhiteTextColor,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            flex: 2,
            child: Text(
              buttonText,
              style: TextStyle(
                color: kButtonTextColor,
                fontSize: 15.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText, secondText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: kGreyNormalTextStyle(context),
          children: [
            TextSpan(
              text: secondText,
              style: kNormalTextStyle().copyWith(
                color: kGreenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleButton extends StatelessWidget {
  const DoubleButton({
    super.key,
    required this.inactiveButton,
    required this.button2Text,
    required this.button2Color,
    required this.button2onPressed,
  });

  final bool inactiveButton;
  final String button2Text;
  final Color button2Color;
  final Function() button2onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Button(
            buttonText: 'Cancel',
            onPressed: () {
              navigatorPop(context);
            },
            buttonColor: kRedColor,
            inactive: false,
          ),
        ),
        SizedBox(width: 5.h),
        Expanded(
          child: Button(
            buttonText: button2Text,
            onPressed: button2onPressed,
            buttonColor: button2Color,
            inactive: inactiveButton,
          ),
        ),
      ],
    );
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.gap,
    this.fontWeight,
  });

  final String text;
  final IconData icon;
  final Color iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? gap;
  final FontWeight? fontWeight;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 10.r),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 25.r,),
            SizedBox(width: gap ?? 20.sp),
            Text(
              text,
              style: kGreyNormalTextStyle(context).copyWith(
                fontSize: fontSize ?? 17.sp,
                color: textColor ?? kTextTheme(context).withOpacity(0.7),
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
