// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class CarouselContainer extends StatelessWidget {
  final String image;
  final String text;

  CarouselContainer({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 50.0,
                  color: Color.fromARGB(255, 177, 177, 177).withOpacity(0.5),
                  spreadRadius: 10.0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: 350.0,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 40.0),
          Text(
            text,
            style: TextStyle(
              color: kTextColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
