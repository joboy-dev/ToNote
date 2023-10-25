// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/note/note_view.dart';
import 'package:todoey/backend/todo/todo_view.dart';

import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/provider/user_provider.dart';

class IsarService {
  late Future<Isar> db;
  final UserView userView = UserView();
  final TodoView todoView = TodoView();
  final NoteView noteView = NoteView();

  IsarService() {
    db = openDB();
  }

  // -------------------GENERIC FUNCTIONS----------------------

  /// Set up DB at app start
  Future<Isar> openDB() async {
    // Check if there is an active DB instance
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      // open isar db
      await Isar.open(
        [UserSchema, TodoSchema, NoteSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  /// Clear database
  Future clearDb(BuildContext context) async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
    // await isar.writeTxn(() => isar.todos.clear());
    // await isar.writeTxn(() => isar.notes.clear());

    // set user provider to null
    Provider.of<UserProvider>(context, listen: false).clearUser();
    log('Clearing user provider -- ${Provider.of<UserProvider>(context, listen: false).user?.email}');
  }

  // -------------------------USERS---------------------------

  /// Function to save a new user at login and update user details in isar DB
  Future saveUser(BuildContext context, User newUser) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.users.putSync(newUser));

    // set new user in provider
    Provider.of<UserProvider>(context, listen: false).setUser(newUser);
    log('Setting user provider -- ${Provider.of<UserProvider>(context, listen: false).user?.email}');

    return newUser;
  }

  /// Function to get logged in user details and set it in provider
  Future<User?> getUserDetails(BuildContext context) async {
    // initialize isar
    final isar = await db;

    // get user details from backend
    var userData = await userView.getUserDetails();

    // check for errors in the request
    if (userData is User) {
      // Debugging
      log('(IsarService) $userData');
      log('(IsarService) user id - ${userData.id}');

      await saveUser(context, userData);

      // create a read transaction to get user details
      final userDoc = await isar.txn(() => isar.users.get(userData.id!));

      log('(IsarService) UserDoc -- $userDoc');

      if (userDoc != null) {
        log('UserDoc -- ${userDoc.firstName}');

        // store user data in provider. listen must be false
        Provider.of<UserProvider>(context, listen: false).setUser(userDoc);
        log('${Provider.of<UserProvider>(context, listen: false).user?.email}');
        return userDoc;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // ------------------------TODOS----------------------------

  /// Function to add new todo and update todo to Isar DB
  Future saveTodo(Todo todo, BuildContext context) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.todos.putSync(todo));

    Provider.of<TodoProvider>(context, listen: false).setTodo(todo);
    log('${Provider.of<TodoProvider>(context, listen: false).todos}');
  }

  /// Function to get current logged inuser todos
  Future getUserTodos(BuildContext context) async {
    final isar = await db;

    // get all user todos
    var userTodos = await todoView.getUserTodos();
    // Todo todo = userTodos;

    if (userTodos is List<Todo>) {
      // loop through all todo items gotten from backend and save in isar
      for (var todo in userTodos) {
        await saveTodo(todo, context);
      }

      final todos = await isar.txn(() => isar.todos.where().findAll());

      Provider.of<TodoProvider>(context, listen: false).setTodos(todos);
      log('${Provider.of<TodoProvider>(context, listen: false).todos}');

      // query isar db for all completed todos
      // final completedTodos = await isar.txn(
      //     () => isar.todos.where().filter().isCompletedEqualTo(true).findAll());

      // save all completed todos in provider
      // Provider.of<TodoProvider>(context, listen: false)
      //     .setCompletedTodos(completedTodos);
      return todos;
    } else {
      return null;
    }
  }

  /// Function to delete a user todo
  Future deleteTodo(int id) async {
    final isar = await db;

    await isar
        .writeTxn(() => isar.todos.where().filter().idEqualTo(id).deleteAll());
  }

  Future addCompletedTodo(int id, BuildContext context) async {
    final isar = await db;

    final completedTodo = await isar
        .txn(() => isar.todos.where().filter().indexIdEqualTo(id).findFirst());

    if (completedTodo != null) {
      Provider.of<TodoProvider>(context, listen: false)
          .setCompletedTodo(completedTodo);
    }
  }

  // ------------------------NOTES-----------------------------

  /// Function to add new note and update existing note in Isar DB
  Future saveNote(Note note, BuildContext context) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.notes.putSync(note));

    // set note in provider
    Provider.of<NoteProvider>(context, listen: false).setNote(note);
    log('${Provider.of<NoteProvider>(context, listen: false).notes}');
  }

  /// Function to get current logged inuser todos
  Future getUserNotes(BuildContext context) async {
    final isar = await db;

    // get all user todos
    var userNotes = await noteView.getUserNotes();

    if (userNotes is List<Note>) {
      // loop through all todo items gotten from backend and save in isar
      for (var note in userNotes) {
        await saveNote(note, context);
      }

      final notes = await isar.txn(() => isar.notes.where().findAll());

      Provider.of<NoteProvider>(context, listen: false).setNotes(notes);
      log('${Provider.of<NoteProvider>(context, listen: false).notes}');

      return notes;
    } else {
      return null;
    }
  }

  /// Function to delete a user todo
  Future deleteNote(int id) async {
    final isar = await db;

    // await isar.writeTxn(() => isar.notes.where().indexIdEqualTo(id).deleteAll());
    await isar
        .writeTxn(() => isar.notes.where().filter().idEqualTo(id).deleteAll());
  }
}
