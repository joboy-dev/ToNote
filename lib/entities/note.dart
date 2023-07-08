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
  // Id indexId = Isar.autoIncrement;
  Id? id;
  String? title;
  String? content;
  String? created;
  String? updated;
  int? ownerId;
  String? ownerEmail;

  @Backlink(to: 'notes')
  var user = IsarLinks<User>();

  Note({
    this.id,
    this.title,
    this.content,
    this.created,
    this.updated,
    this.ownerEmail,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      created: json['created_at'],
      updated: json['updated_at'],
      ownerEmail: json['author'],
    );
  }
}
