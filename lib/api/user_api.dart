// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoey/models/user.dart';

String baseUrl = 'https://todo-ey.onrender.com';

class UserAPI {
  // function to create user account
  Future createAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String password2,
    String profilePic = '',
  }) async {
    try {
      final endpoint = '$baseUrl/user/register/';
      // parse endpoint as a Uri
      final url = Uri.parse(endpoint);
      print(url);

      // create map of json data
      Map<String, dynamic> jsonData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'password2': password2,
        'profilePic': profilePic,
      };

      // create appropriate request -- in this case, a post request
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );
      print(response.statusCode);

      // check if response status code is 200
      if (response.statusCode == 200) {
        // store response
        var data = UserModel.fromJson(jsonDecode(response.body));
        print(data);

        // return response
        return data;
      } else {
        throw Exception('----------EXCEPTION THROWN----------\nFailed');
      }
    } catch (e) {
      print('-------------EXCEPTION THROWN------------');
      print(e.toString());
      return e.toString();
    }
  }

  // function to log in a user to their account
  login() async {}
}
