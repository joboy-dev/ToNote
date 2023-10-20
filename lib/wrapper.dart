// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/services/token_storage.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/shared/bottom_navbar.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  static const String id = 'wrapper/';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  /* variable to store user token which will help in the appropriate screen
   to navigate to upon leaving the onboarding screen */
  String? _token;

  final TokenStorage _storage = TokenStorage();

  final _isarService = IsarService();

  var data;

  @override
  void initState() {
    // Waiting for data to be gotten.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? token = await _storage.getToken();
      setState(() {
        _token = token;
      });

      // get user details before it is stored in provider
      // this is done to get the user dark mode value
      var user = await _isarService.getUserDetails(context);
      if (user is User) {
        log('(Wrapper) user -- ${user.firstName}');

        var todos = await _isarService.getUserTodos(context);
        if (todos is List<Todo>) {
          log('(Wrapper) todos length -- ${todos.length} ');

          var notes = await _isarService.getUserNotes(context);
          if (notes is List<Note>) {
            log('(Wrapper) notes length -- ${notes.length} ');
          }
        }
      } else {
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Wrapper widget read token from storage -- $_token');

    if (_token == null && data == null) {
      return const GetStarted();
    } else {
      // store user details in future provider
      return FutureProvider.value(
        value: _isarService.getUserDetails(context),
        initialData: null,
        catchError: (context, error) {
          log('(Wrapper) FutureProvider user Error -- $error');
        },
        // store user todos in future provider
        child: FutureProvider.value(
          value: _isarService.getUserTodos(context),
          initialData: null,
          catchError: (context, error) {
            log('(Wrapper) FutureProvider todos Error -- $error');
          },
          child: FutureProvider.value(
              value: _isarService.getUserNotes(context),
              initialData: null,
              catchError: (context, error) {
                log('(Wrapper) FutureProvider notes Error -- $error');
              },
              child: const BottomNavBar(),),
        ),
      );
    }
  }
}
