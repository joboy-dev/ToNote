// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/carousel.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  static const String id = 'get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with TickerProviderStateMixin {
  List<CarouselContainer> carousel = [
    CarouselContainer(
      image: 'assets/images/onboarding1.png',
      text: 'Manage your tasks with efficiency',
    ),
    CarouselContainer(
      image: 'assets/images/onboarding4.png',
      text: 'Take notes and ensure you remain up to date on various activities',
    ),
    CarouselContainer(
      image: 'assets/images/onboarding2.png',
      text: 'Handle tasks wherever you are in the world',
    ),
    CarouselContainer(
      image: 'assets/images/onboarding3.png',
      text: 'Manage multiple tasks at once',
    ),
  ];

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  
  late AnimationController _controller1;
  late AnimationController _controller2;

  @override
  void initState() {
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _controller1.forward().whenComplete(() {
      _controller2.forward();
    });

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    ));

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    ));

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.bounceIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideTransition(
                position: slideTransitionAnimation(
                  dx: -1,
                  dy: -1,
                  animation: _animation3,
                ),
                child: CarouselSlider(
                  // map through the list of carousel
                  items: carousel.map((newCarousel) {
                    return CarouselContainer(
                      image: newCarousel.image,
                      text: newCarousel.text,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 585.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    viewportFraction: 0.85,
                  ),
                ),
              ),
              Padding(
                padding: kAppPadding,
                child: Column(
                  children: [
                    SlideTransition(
                      position: slideTransitionAnimation(
                        dx: -2,
                        dy: 0,
                        animation: _animation2,
                      ),
                      child: Button(
                        buttonText: 'Create Account',
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.id);
                        },
                        buttonColor: kGreenColor,
                        inactive: false,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SlideTransition(
                      position: slideTransitionAnimation(
                        dx: 0,
                        dy: 2,
                        animation: _animation2,
                      ),
                      child: Button(
                        buttonText: 'Login',
                        onPressed: () {
                          Navigator.pushNamed(context, Login.id);
                        },
                        buttonColor: kYellowColor,
                        inactive: false,
                      ),
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
