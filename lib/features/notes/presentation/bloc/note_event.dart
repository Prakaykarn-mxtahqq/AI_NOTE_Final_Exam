abstract class NoteEvent {}

class LoadNotesEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String content;
  final String summary;

  AddNoteEvent({
    required this.title,
    required this.content,
    required this.summary,
  });
}

class DeleteNoteEvent extends NoteEvent {
  final int id;

  DeleteNoteEvent(this.id);
}
