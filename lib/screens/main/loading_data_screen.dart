import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  void initState() {
    // Waiting for data to be gotten.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await IsarService().getUserDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;

    return user == null
        ? const Center(child: LoadingScreen(color: kOrangeColor))
        : const BottomNavBar();
  }
}
