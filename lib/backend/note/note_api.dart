import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:todoey/backend/endpoints.dart';
import 'package:todoey/services/token_storage.dart';

/// This class handles all requests for note endpoints
class NoteAPI {
  // Initialize token storage class
  final TokenStorage tokenStorage = TokenStorage();

  // store all headers in a function
  Map<String, String> getHeaders(String token) => {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };

  // Function to handle all adding notes responses
  Future addNote({required dynamic data}) async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting details of user $token');

      var response = await http.post(
        Uri.parse(createNoteEndpoint),
        headers: getHeaders(token),
        body: jsonEncode(data),
      );

      var responseData = jsonDecode(response.body);

      log("STATUS CODE -- ${response.statusCode}");

      if (response.statusCode == 201) {
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
        await addNote(data: data);

        // return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      await addNote(data: data);

      // return null;
    }
  }

  /// Function to handle geting user notes responses
  Future getNotes() async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting details of user $token');

      var response = await http.get(
        Uri.parse(userNotesEndpoint),
        headers: getHeaders(token),
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
        await getNotes();

        // return null;
      }
    } catch (e) {
      log('-------------EXCEPTION THROWN------------');
      log(e.toString());

      await getNotes();

      // return null;
    }
  }

  /// Function to handle updating user notes responses
  Future updateNote(dynamic data, int id) async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting details of user $token');

      var response = await http.patch(
        Uri.parse(getNoteDetailEndpoint(id)),
        headers: getHeaders(token),
        body: jsonEncode(data),
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

  /// Function to handle deleting user todos responses
  Future deleteNote(int id) async {
    try {
      // get user token
      var token = await tokenStorage.readToken();
      log('Getting details of user $token');

      var response = await http.delete(
        Uri.parse(getNoteDetailEndpoint(id)),
        headers: getHeaders(token),
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
}
