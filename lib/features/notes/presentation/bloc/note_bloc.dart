import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../../../../../core/database/database_helper.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  NoteBloc() : super(NoteInitial()) {

    /// LOAD NOTES
    on<LoadNotesEvent>((event, emit) async {

      emit(NoteLoading());

      final notes = await DatabaseHelper.instance.getNotes();

      emit(NoteLoaded(notes));
    });

    /// ADD NOTE
    on<AddNoteEvent>((event, emit) async {

      final note = Note(
        title: event.title,
        content: event.content,
        summary: event.summary,
      );

      await DatabaseHelper.instance.insertNote(note);

      final notes = await DatabaseHelper.instance.getNotes();

      emit(NoteLoaded(notes));
    });

    /// DELETE NOTE
    on<DeleteNoteEvent>((event, emit) async {

      await DatabaseHelper.instance.deleteNote(event.id);

      final notes = await DatabaseHelper.instance.getNotes();

      emit(NoteLoaded(notes));
    });

  }

}
