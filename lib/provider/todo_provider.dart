import 'package:flutter/material.dart';
import 'package:todoey/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  String title = '';
  DateTime date = DateTime.now();
  bool isCompleted = false;

  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  // addTodo({required String title, required DateTime date}) {
  //   TodoModel newTodo = TodoModel(
  //     title: title,
  //     isCompleted: false,
  //     expire: date,
  //   );
  //   _todos.add(newTodo);
  //   notifyListeners();
  //   print(_todos);
  // }
}
