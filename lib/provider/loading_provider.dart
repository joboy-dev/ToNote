import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool? isLoading;

  setFalse() {
    isLoading = false;
    notifyListeners();
  }

  setTrue() {
    isLoading = true;
    notifyListeners();
  }
}
