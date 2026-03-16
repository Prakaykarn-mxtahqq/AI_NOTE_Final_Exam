class Note {

  final int? id;
  final String title;
  final String content;
  final String summary;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      summary: map['summary'] ?? "",
    );
  }
}
