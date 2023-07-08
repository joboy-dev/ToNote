import 'package:isar/isar.dart';
import 'package:todoey/entities/user.dart';

part 'todo.g.dart';

class TodoModel {
  String title;
  bool isCompleted;
  String expire;
  // DateTime expire;

  TodoModel({
    required this.title,
    required this.isCompleted,
    required this.expire,
  });
}

@Collection()
class Todo {
  Id? id;
  int indexId = Isar.autoIncrement;
  String? title;
  bool? isCompleted;
  String? expire;
  // int? ownerId;
  String? ownerEmail;

  @Backlink(to: 'todos')
  var user = IsarLinks<User>();

  Todo({
    this.id,
    this.title,
    this.isCompleted,
    this.expire,
    this.ownerEmail,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['name'],
      isCompleted: json['is_completed'],
      expire: json['due_date'],
      ownerEmail: json['owner'],
    );
  }
}
