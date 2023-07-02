import 'package:isar/isar.dart';
import 'package:todoey/entities/user.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id? id;
  String? title;
  String? content;
  DateTime? created;
  DateTime? updated;

  @Backlink(to: 'notes')
  final user = IsarLinks<User>();
}
