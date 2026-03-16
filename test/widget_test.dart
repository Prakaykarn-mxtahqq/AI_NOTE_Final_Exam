import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:ai_note_scanner/features/notes/presentation/pages/home_page.dart';
import 'package:ai_note_scanner/features/notes/presentation/bloc/note_bloc.dart';

void main() {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('HomePage shows title', (WidgetTester tester) async {

    await tester.pumpWidget(

      MaterialApp(

        home: BlocProvider(
          create: (_) => NoteBloc(),
          child: const HomePage(),
        ),

      ),

    );

    await tester.pump();

    expect(find.text("AI Notes"), findsOneWidget);

  });

}
