import '../../../../core/database/database_helper.dart';
import '../models/note_model.dart';

class NoteLocalDataSource {

  final DatabaseHelper dbHelper;

  NoteLocalDataSource(this.dbHelper);

  Future<void> insertNote(NoteModel note) async {

    final db = await dbHelper.database;

    await db.insert(
      'notes',
      note.toMap(),
    );
  }

  Future<List<NoteModel>> getNotes() async {

    final db = await dbHelper.database;

    final result = await db.query('notes');

    return result.map((e) => NoteModel.fromMap(e)).toList();
  }
}
