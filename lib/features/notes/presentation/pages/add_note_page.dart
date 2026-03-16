import 'dart:io';
import 'package:ai_note_scanner/features/notes/data/services/ai_service.dart';
import 'package:ai_note_scanner/features/notes/data/services/ocr_service.dart';
import 'package:ai_note_scanner/features/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../../core/database/database_helper.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class AddNotePage extends StatefulWidget {

  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;

  /// SCAN IMAGE + OCR
  Future<void> scanImage() async {

    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      isLoading = true;
    });

    final ocr = OCRService();
    String text = await ocr.extractText(File(image.path));

    final ai = AIService();

    text = await ai.fixOCR(text);
    text = await ai.summarize(text);

    final title = await ai.generateTitle(text);

    setState(() {
      contentController.text = text;
      titleController.text = title;
      isLoading = false;
    });
  }

  /// SAVE NOTE
  Future<void> saveNote() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final ai = AIService();

    final content = contentController.text;

    final summary = await ai.summarize(content);

    String title = titleController.text;

    // if (title.isEmpty) {
    //   title = await ai.generateTitle(content);
    // }

    final note = Note(
      title: title,
      content: content,
      summary: summary,
    );

    await DatabaseHelper.instance.insertNote(note);

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      context.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create AI Note"),
        centerTitle: true,
      ),

      body: Stack(

        children: [

          SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Form(
              key: _formKey,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "New Note",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// TITLE
                  TextFormField(

                    controller: titleController,

                    decoration: InputDecoration(

                      labelText: "Title",

                      prefixIcon: const Icon(Icons.title),

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),

                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return "Please enter title";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// CONTENT
                  TextFormField(

                    controller: contentController,

                    maxLines: 8,

                    decoration: InputDecoration(

                      labelText: "Note Content",

                      alignLabelWithHint: true,

                      prefixIcon: const Icon(Icons.notes),

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// SCAN BUTTON
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: scanImage,

                      icon: const Icon(Icons.document_scanner),

                      label: const Text(
                        "Scan From Image",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// SAVE BUTTON
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(

                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),

                        backgroundColor: Colors.indigo,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: isLoading ? null : saveNote,

                      child: const Text(
                        "Save Note",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          /// LOADING OVERLAY
          if (isLoading)
            Container(

              color: Colors.black26,

              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
