import 'package:flutter/material.dart';
import 'package:todoey/entities/user.dart';

/* This class is used in conjunction with the isar db, so when data is added
to the db, it will be set here . For this provider to work, the function
handling getting user data from the isar db must be set as a FUTURE PROVIDER
in main function.
*/
class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  /// Function to add user to the provider
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  /// Used when a user logs out, so there won't be any data of the user in the
  /// provider
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
