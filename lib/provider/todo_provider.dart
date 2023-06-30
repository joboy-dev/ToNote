import 'package:flutter/material.dart';
import 'package:todoey/entities/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void setTodo(Todo todoItem) {
    _todos.add(todoItem);
    notifyListeners();
  }
}
