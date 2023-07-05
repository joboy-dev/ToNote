import 'dart:developer';

import 'package:todoey/backend/todo/todo_api.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/entities/user.dart';

class TodoView {
  final _userView = UserView();
  final _todoAPI = TodoAPI();

  /// Function to add new todo
  addTodo({required TodoModel todo}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      // create map of json data
      Map<String, dynamic> jsonData = {
        "name": todo.title,
        "ic_completed": todo.isCompleted,
        "due_date": todo.expire,
        "owner": userData.id,
      };

      // store data gotten from response in todo api
      var data = await _todoAPI.addTodo(data: jsonData);

      if (data is Map<String, dynamic>) {
        final todoData = Todo.fromJson(data);
        log(' New todo added -- ${todoData.title}');
        return todoData;
      } else {
        return data;
      }
    }
  }

  /// Function to get all user todos
  getUserTodos() async {
    var jsonData = await _todoAPI.getTodos();

    if (jsonData is List) {
      // convert jsondata into a Todo model
      final todos = jsonData.map((data) => Todo.fromJson(data)).toList();

      log('Getting user todos text -- ${todos.first}');
      return todos;
    }
  }

  /// Function to update user todo
  updateTodo({required TodoModel todo, required int id}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      // create map of json data
      Map<String, dynamic> jsonData = {
        "name": todo.title,
        "ic_completed": todo.isCompleted,
        "due_date": todo.expire,
        "owner": userData.id,
      };
      var data = await _todoAPI.updateTodo(jsonData, id);

      if (data is Map<String, dynamic>) {
        final todoData = Todo.fromJson(data);

        return todoData;
      } else {
        return data;
      }
    }
  }

  /// Function to delete user todo
  deleteTodo({required int id}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      var data = await _todoAPI.deleteTodo(id);
      return data;
    }
  }
}
