import 'package:flutter/material.dart';
import 'package:todoey/entities/todo.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> _completedTodos = [];

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos => _completedTodos;

  void setTodo(Todo todoItem) {
    _todos.add(todoItem);
    notifyListeners();
  }

  void setTodos(List<Todo> todoItems) {
    _todos = todoItems;
    notifyListeners();
  }

  void setMoreTodos(List<Todo> items) {
    _todos.addAll(items);
    notifyListeners();
  }

  void setCompletedTodo(Todo todoItem) {
    _completedTodos.add(todoItem);
    notifyListeners();
  }
}
