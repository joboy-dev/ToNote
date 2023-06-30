import 'package:isar/isar.dart';
import 'package:todoey/entities/user.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  String? title;
  bool? isCompleted;
  DateTime? expire;

  @Backlink(to: 'todos')
  final user = IsarLinks<User>();
}
