// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/carousel.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  static const String id = 'get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  List<CarouselContainer> carousel = [
    CarouselContainer(
      image: 'assets/onboarding1.png',
      text: 'Manage your tasks with efficiency',
    ),
    CarouselContainer(
      image: 'assets/onboarding2.png',
      text: 'Handle tasks wherever you are in the world',
    ),
    CarouselContainer(
      image: 'assets/onboarding3.png',
      text: 'Manage multiple tasks at once',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                // map through the list of carousel
                items: carousel.map((newCarousel) {
                  return CarouselContainer(
                    image: newCarousel.image,
                    text: newCarousel.text,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 555.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  viewportFraction: 0.85,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: kAppPadding,
                child: Column(
                  children: [
                    Button(
                      buttonText: 'Create Account',
                      onPressed: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      buttonColor: kGreenColor,
                      inactive: false,
                    ),
                    SizedBox(height: 20.0),
                    Button(
                      buttonText: 'Login',
                      onPressed: () {
                        Navigator.pushNamed(context, Login.id);
                      },
                      buttonColor: kYellowColor,
                      inactive: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
