import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/shared/constants.dart';

class CarouselContainer extends StatelessWidget {
  final String image;
  final String text;

  const CarouselContainer({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: kHeightWidth(context).height * 0.35,
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          text,
          // style: TextStyle(
          //   color: kGreyTextColor,
          //   fontSize: 20.sp,
          //   fontFamily: 'Poppins',
          //   fontWeight: FontWeight.bold,
          // ),
          style: kGreyNormalTextStyle(context).copyWith(
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
