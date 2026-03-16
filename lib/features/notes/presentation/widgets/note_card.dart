import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {

  final String title;
  final String summary;

  const NoteCard({
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),

      child: ListTile(
        title: Text(title),
        subtitle: Text(summary),
      ),
    );
  }
}
