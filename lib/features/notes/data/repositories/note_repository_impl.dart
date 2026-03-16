import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasource/note_local_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {

  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl(this.localDataSource);

  @override
  Future<void> addNote(Note note) async {

    final model = NoteModel(
      title: note.title,
      content: note.content,
      summary: note.summary,
    );

    await localDataSource.insertNote(model);
  }

  @override
  Future<List<Note>> getNotes() {

    return localDataSource.getNotes();
  }
}
