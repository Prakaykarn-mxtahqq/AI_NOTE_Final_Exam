import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ai_note_scanner/main.dart' as app;

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add note end-to-end test', (tester) async {

    app.main();
    await tester.pumpAndSettle();

    /// กด Add Note
    await tester.tap(find.text("Add Note"));
    await tester.pumpAndSettle();

    /// ใส่ Title
    await tester.enterText(find.byType(TextFormField).first, "Test Note");

    /// ใส่ Content
    await tester.enterText(find.byType(TextFormField).last, "Test Content");

    /// กด Save
    await tester.tap(find.text("Save Note"));

    await tester.pumpAndSettle();

    /// ตรวจว่า note ปรากฏในหน้า Home
    expect(find.text("Test Note"), findsOneWidget);

  });

}
