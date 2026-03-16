import 'package:flutter_test/flutter_test.dart';
import 'package:ai_note_scanner/features/notes/domain/entities/note.dart';

void main() {

  group('Note Model Test', () {

    test('Note should create correctly', () {

      final note = Note(
        title: "Test Title",
        content: "Test Content",
        summary: "Test Summary",
      );

      expect(note.title, "Test Title");
      expect(note.content, "Test Content");
      expect(note.summary, "Test Summary");

    });

  });

}
