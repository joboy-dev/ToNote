// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:todoey/services/token_storage.dart';

class AuthProvider with ChangeNotifier {
  var _token ;
  dynamic get token => _token;

  TokenStorage storage = TokenStorage();

  // function to set token into secure storage
  void setToken(String userToken) async {
    await storage.writeToken(token: userToken);

    // set token value by reading token value from storage
    _token = userToken;

    notifyListeners();
    log('User token in Provider -- $_token');
  }

  // function to clear token from secure storage
  void clearToken() async {
    await storage.deleteToken();
    _token = await storage.readToken();

    notifyListeners();
    log('User token in Provider -- $_token');
  }
}
