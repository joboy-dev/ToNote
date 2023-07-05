import 'dart:developer';
import 'dart:io';

import 'package:todoey/backend/user/user_api.dart';
import 'package:todoey/entities/user.dart';

/// THIS VIEW IS PUT IN PLACE TO HANDLE USER RELATED FUNCTIONALITY
class UserView {
  // Initialize UserApi class where all response data will be used
  final UserAPI _userAPI = UserAPI();

  /// FUNCTION TO HANDLE USER ACCOUNT CREATION
  createAccount({required UserModel user}) async {
    // create map of json data
    Map<String, dynamic> jsonData = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email": user.email,
      "password": user.password,
      "password2": user.password2,
    };

    // store data gotten from response in user api
    var data = await _userAPI.createAccount(data: jsonData);

    if (data is Map<String, dynamic>) {
      final user = User.fromJson(data);
      return user;
    } else {
      // store returned data
      return data;
    }
  }

  /// FUNCTION TO HANDLE USER LOGIN
  login({required String email, required String password}) async {
    // create map of json data
    Map<String, dynamic> jsonData = {
      "email": email,
      "password": password,
    };

    var data = await _userAPI.login(data: jsonData);

    return data;
  }

  /// FUNCTION TO HANDLE LOGOUT
  logout() async {
    var data = await _userAPI.logout();

    return data;
  }

  /// FUNCTION TO GET USER DETAILS
  getUserDetails() async {
    var data = await _userAPI.getUserDetails();
    log('$data');

    if (data is Map<String, dynamic>) {
      final user = User.fromJson(data);
      return user;
    } else {
      return data;
    }

  }

  /// FUNCTION TO GET USER PROFILE PICTURE
  getUserProfilePicture() async {
    var data = await _userAPI.getUserProfilePicture();

    return data;
  }

  /// FUNCTION TO UPLOAD USER PROFILE PICTURE
  uploadUserProfilePicture(File profilePic) async {
    var data = await _userAPI.uploadUserProfilePicture(file: profilePic);

    return data;
  }

  /// FUNCTION TO UPDATE USER DETAILS
  updateUserDetails({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    Map<String, dynamic> jsonData = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };

    var data = await _userAPI.updateUserDetails(jsonData);

    return data;
  }

  /// FUNCTION TO CHANGE USER PASSWORD
  changePassword({
    required String email,
    required String olaPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> jsonData = {
      "email": email,
      "password": olaPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };

    var data = await _userAPI.changePassword(jsonData);

    return data;
  }
}
