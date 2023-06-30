import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingTimer extends ChangeNotifier {
  bool isLoading = true;
  String message = '';

  Timer? timer;

  // setting a timer for user data to load
  startTimer() {
    bool isLoading = true;
    timer = Timer(Duration(milliseconds: 100), () {
      if (isLoading) {
        isLoading = false;
        message = 'This request is taking too long.';

        notifyListeners();
      }
    });
  }
}
