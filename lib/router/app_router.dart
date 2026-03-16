import 'package:ai_note_scanner/features/notes/domain/entities/note.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import '../features/notes/presentation/pages/home_page.dart';
import '../features/notes/presentation/pages/add_note_page.dart';
import '../features/notes/presentation/pages/note_detail_page.dart';
  
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: AddNoteRoute.page),
    AutoRoute(page: NoteDetailRoute.page),
  ];
}
