import 'package:ai_note_scanner/features/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class NoteDetailPage extends StatelessWidget {

  final Note note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: Hero(
          tag: "note_${note.id}",
          child: Material(
            color: Colors.transparent,
            child: Text(
              note.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// NOTE TITLE
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// NOTE INFO
            Row(
              children: [

                Icon(
                  Icons.auto_awesome,
                  size: 18,
                  color: Colors.indigo.shade400,
                ),

                const SizedBox(width: 6),

                Text(
                  "AI Generated Summary",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            /// SUMMARY HEADER
            const Text(
              "AI Summary",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// SUMMARY CARD
            Container(
              width: double.infinity,

              decoration: BoxDecoration(

                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade50,
                    Colors.blue.shade50,
                  ],
                ),

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),

              padding: const EdgeInsets.all(18),

              child: Text(

                note.summary.isEmpty
                    ? "No summary generated"
                    : note.summary,

                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// CONTENT HEADER
            Row(
              children: const [

                Icon(Icons.article_outlined),

                SizedBox(width: 8),

                Text(
                  "Original Content",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// CONTENT CARD
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),

              padding: const EdgeInsets.all(18),

              child: SelectableText(
                note.content,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
