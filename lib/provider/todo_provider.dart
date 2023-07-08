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

  // for pagination
  void setMoreTodos(List<Todo> items) {
    _todos.addAll(items);
    notifyListeners();
  }

  void setCompletedTodo(Todo todoItem) {
    _completedTodos.add(todoItem);
    // _completedTodos.insert(index, todoItem);
    notifyListeners();
  }

  void setCompletedTodos(List<Todo> todoItems) {
    // void setCompletedTodos(int index, List<Todo> todoItems) {
    // _completedTodos = todoItems;

    // check if the list is empty to know the index to place the list items
    if (todoItems.isEmpty) {
      _completedTodos.insertAll(0, todoItems);
      notifyListeners();
    } else {
      _completedTodos.insertAll(todoItems.length - 1, todoItems);
      notifyListeners();
    }
  }
}
