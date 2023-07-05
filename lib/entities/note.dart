import 'package:isar/isar.dart';
import 'package:todoey/entities/user.dart';

part 'note.g.dart';

class NoteModel {
  String title;
  String content;

  NoteModel({
    required this.title,
    required this.content,
  });
}

@Collection()
class Note {
  Id? id;
  String? title;
  String? content;
  DateTime? created;
  DateTime? updated;
  int? ownerId;
  String? ownerEmail;

  @Backlink(to: 'notes')
  var user = IsarLinks<User>();
}
