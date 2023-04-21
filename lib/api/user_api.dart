// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

class UserAPI {
  String host = 'http://127.0.0.1:5100/';

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
      final endpoint = '$host/user/register/';
      final url = Uri.parse(endpoint);

      Map<String, dynamic> jsonData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'password2': password2,
        'profilePic': profilePic,
      };

      var response = await http.post(url, body: jsonData);
      if (response.statusCode == 200) {
        // store response
        var data = response.body;
        // return response
        return data;
      } else {
        throw Exception('Failed');
      }
    } catch (e) {
      print('-------------EXCEPTION------------');
      print(e.toString());
    }
  }

  // function to log in a user to their account
  login() async {}
}
