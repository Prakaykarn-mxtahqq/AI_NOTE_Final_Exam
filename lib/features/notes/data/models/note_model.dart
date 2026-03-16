import '../../domain/entities/note.dart';

class NoteModel extends Note {

  NoteModel({
    int? id,
    required String title,
    required String content,
    required String summary,
  }) : super(
          id: id,
          title: title,
          content: content,
          summary: summary,
        );

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {

    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      summary: map['summary'],
    );
  }
}
