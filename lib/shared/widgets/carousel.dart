import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class CarouselContainer extends StatelessWidget {
  final String image;
  final String text;

  const CarouselContainer({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: 50.0,
            //     color: Color.fromARGB(255, 177, 177, 177).withOpacity(0.5),
            //     spreadRadius: 10.0,
            //     offset: Offset(0, 3),
            //   ),
            // ],
          ),
          height: 350.0,
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30.0),
        Text(
          text,
          style: const TextStyle(
            color: kGreyTextColor,
            fontSize: 20.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
