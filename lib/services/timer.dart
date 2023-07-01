import 'dart:async';

import 'package:flutter/material.dart';

class LoadingTimer extends ChangeNotifier {
  bool isLoading = false;
  String message = '';

  Timer? timer;

  // setting a timer for user data to load
  startTimer() {
    bool isLoading = true;
    timer = Timer(const Duration(milliseconds: 100), () {
      if (isLoading) {
        isLoading = false;
        message = 'This request is taking too long.';

        notifyListeners();
      }
    });
  }

  cancelTimer() {
    timer?.cancel();
    notifyListeners();
  }
}
