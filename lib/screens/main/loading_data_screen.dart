// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';

class LoadingDataScreen extends StatefulWidget {
  const LoadingDataScreen({super.key});

  static const String id = 'loading_data';

  @override
  State<LoadingDataScreen> createState() => _LoadingDataScreenState();
}

class _LoadingDataScreenState extends State<LoadingDataScreen> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: IsarService().getUserDetails(),
    //   builder: (context, snapshot) {
    //     log('(LoadingData) Snapshot connection state -- ${snapshot.connectionState}');
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       log('(LoadingData) Snapshot data -- ${snapshot.data}');
    //       final User? _user = snapshot.data;
    //       log('User -- $_user');
    //       log('User -- ${_user?.firstName}');
    final _user = Provider.of<UserProvider?>(context)?.user;

    return _user == null
        ? Center(child: LoadingScreen(color: kOrangeColor))
        : BottomNavBar();
    // } else {
    //   return Center(child: ConnectingScreen(color: kOrangeColor));
    // }
    // },
    // );
  }
}
