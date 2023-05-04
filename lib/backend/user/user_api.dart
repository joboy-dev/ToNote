// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:todoey/backend/endpoints.dart';
import 'package:todoey/services/user/token_storage.dart';
import 'package:todoey/provider/auth_provider.dart';

/// THIS VIEW IS PUT IN PLACE TO HANDLE USER RELATED RESPONSES
class UserAPI {
  final AuthProvider _authProvider = AuthProvider();

  // initialize flutter secure storage to store user token
  final storage = const FlutterSecureStorage();

  // Initialize token storage class
  final TokenStorage tokenStorage = TokenStorage();

  var endpoint = '';

  var authToken = '';

  // create map of hraders
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // FUNCTION TO HANDLE CREATE ACCOUNT RESPONSES
  Future createAccount({
    required dynamic data,
  }) async {
    try {
      // store response in a variable
      var response = await http.post(
        Uri.parse(registerEndpoint),
        headers: headers,
        body: jsonEncode(data),
      );

      log('STATUS CODE -- ${response.statusCode}');

      // store response data
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        log('-----------------RESPONSE 201 DATA-----------------');
        log("$responseData");
        // log('${responseData['first_name']}');

        return response.statusCode;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        log('${responseData as Map}');

        var result =
            responseData['email'][0] = 'User with this email already exists.';

        log(result);

        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      return null;
    }
  }

  /// FUNCTION TO HANDLE LOGIN RESPONSES
  Future login({required dynamic data}) async {
    try {
      var response = await http.post(
        Uri.parse(loginEndpoint),
        body: jsonEncode(data),
        headers: headers,
      );

      log('STATUS CODE -- ${response.statusCode}');

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log('-----------------RESPONSE 200 DATA-----------------');
        log('$responseData');
        log('User Token -- ${responseData['token']}');

        // set token variable in AuthProvideer class
        _authProvider.setToken(responseData['token']);

        return response.statusCode;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        log('$responseData');
        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());
      return null;
    }
  }

  /// FUNCTION TO HANDLE LOGOUT RESPONSES
  Future logout() async {
    try {
      // read user token from secure storage
      var token = await tokenStorage.readToken();
      log('Logging user with $token out');

      headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };

      var response =
          await http.post(Uri.parse(logoutEndpoint), headers: headers);

      var responseData = jsonDecode(response.body);

      log("STATUS CODE -- ${response.statusCode}");

      if (response.statusCode == 200) {
        log('-----------------RESPONSE 200 DATA-----------------');
        log('$responseData');

        // clear the token and set it to null
        _authProvider.clearToken();

        return response.statusCode;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else if (response.statusCode == 401) {
        log('-----------------RESPONSE 401 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      return null;
    }
  }

  /// FUNCTION TO HANDLE GETTING USER DETAILS RESPONSES
  Future getUserDetails() async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting details of user $token');

      headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };

      var response = await http.get(
        Uri.parse(userDetailsEndpoint),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);

      log("STATUS CODE -- ${response.statusCode}");

      if (response.statusCode == 200) {
        log('-----------------RESPONSE 200 DATA-----------------');
        log('$responseData');

        return responseData;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else if (response.statusCode == 401) {
        log('-----------------RESPONSE 401 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      // check if connection times out
      if (e.toString() == 'Connection timed out') {
        return e.toString();
      } else {
        return null;
      }
    }
  }

  /// FUNCTION TO HANDLE GETTING USER PROFILE PICTURE RESPONSES
  Future getUserProfilePicture() async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting profile picture of user $token');

      headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };

      var response = await http.get(
        Uri.parse(getUploadPictureEndpoint),
        headers: headers,
      );

      var responseData = jsonDecode(response.body);

      log("STATUS CODE -- ${response.statusCode}");

      if (response.statusCode == 200) {
        log('-----------------RESPONSE 200 DATA-----------------');
        log('$responseData');

        return responseData;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else if (response.statusCode == 401) {
        log('-----------------RESPONSE 401 DATA-----------------');
        log('$responseData');

        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      return null;
    }
  }

  /// FUNCTION TO HANDLE GETTING USER PROFILE PICTURE RESPONSES
  Future uploadUserProfilePicture({required File file}) async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting profile picture of user $token');

      headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };

      var request =
          http.MultipartRequest('POST', Uri.parse(getUploadPictureEndpoint));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      // var responseData = jsonDecode(response.body);

      log("STATUS CODE -- ${response.statusCode}");
      log('$response');

      if (response.statusCode == 200) {
        log('-----------------RESPONSE 200 DATA-----------------');
        log('$response');

        return response.statusCode;
      } else if (response.statusCode == 400) {
        log('-----------------RESPONSE 400 DATA-----------------');
        // log('$responseData');

        return response.statusCode;
      } else if (response.statusCode == 401) {
        log('-----------------RESPONSE 401 DATA-----------------');
        // log('$responseData');

        return response.statusCode;
      } else {
        log('Request Failed');
        return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      return null;
    }
  }
}
