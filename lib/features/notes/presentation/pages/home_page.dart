import 'package:ai_note_scanner/features/notes/domain/entities/note.dart';
import 'package:ai_note_scanner/features/notes/presentation/bloc/note_bloc.dart';
import 'package:ai_note_scanner/features/notes/presentation/bloc/note_event.dart';
import 'package:ai_note_scanner/features/notes/presentation/bloc/note_state.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../router/app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// โหลดโน้ตตอนเปิดหน้า
    context.read<NoteBloc>().add(LoadNotesEvent());
  }

  List<Note> filterNotes(List<Note> notes) {

    final query = searchController.text.toLowerCase();

    if (query.isEmpty) return notes;

    return notes.where((note) {

      return note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);

    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "AI Notes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(

        onPressed: () async {

          await context.router.push(const AddNoteRoute());

          /// reload notes หลังเพิ่ม
          context.read<NoteBloc>().add(LoadNotesEvent());
        },

        icon: const Icon(Icons.add),
        label: const Text("Add Note"),
      ),

      body: BlocBuilder<NoteBloc, NoteState>(

        builder: (context, state) {

          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NoteLoaded) {

            final notes = state.notes;

            final filteredNotes = filterNotes(notes);

            return Column(
              children: [

                /// SEARCH BAR
                Padding(
                  padding: const EdgeInsets.all(16),

                  child: TextField(

                    controller: searchController,

                    onChanged: (_) => setState(() {}),

                    decoration: InputDecoration(

                      hintText: "Search your notes...",

                      prefixIcon: const Icon(Icons.search),

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),

                    ),
                  ),
                ),

                /// NOTE COUNT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Row(
                    children: [

                      Text(
                        "${filteredNotes.length} Notes",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// NOTE LIST
                Expanded(

                  child: filteredNotes.isEmpty
                      ? const Center(
                          child: Text(
                            "No Notes Found",
                            style: TextStyle(fontSize: 18),
                          ),
                        )

                      : ListView.builder(

                          padding: const EdgeInsets.all(12),

                          itemCount: filteredNotes.length,

                          itemBuilder: (context, index) {

                            final note = filteredNotes[index];

                            return Card(

                              elevation: 4,

                              margin: const EdgeInsets.symmetric(vertical: 8),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: ListTile(

                                contentPadding:
                                    const EdgeInsets.all(18),

                                title: Hero(

                                  tag: "note_${note.id}",

                                  child: Material(

                                    color: Colors.transparent,

                                    child: Text(

                                      note.title,

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),

                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),

                                  child: Text(

                                    note.summary.isEmpty
                                        ? note.content
                                        : note.summary,

                                    maxLines: 2,

                                    overflow: TextOverflow.ellipsis,

                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),

                                onTap: () {

                                  context.router.push(
                                    NoteDetailRoute(note: note),
                                  );

                                },

                                trailing: IconButton(

                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),

                                  onPressed: () {

                                    context.read<NoteBloc>().add(
                                          DeleteNoteEvent(note.id!),
                                        );

                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
