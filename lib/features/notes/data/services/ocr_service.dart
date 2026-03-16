import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../../core/utils/text_cleaner.dart';

class OCRService {

  Future<String> extractText(File file) async {

    final inputImage = InputImage.fromFile(file);

    final textRecognizer = TextRecognizer();

    final recognizedText =
        await textRecognizer.processImage(inputImage);

    StringBuffer buffer = StringBuffer();

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        buffer.writeln(line.text);
      }
    }

    await textRecognizer.close();

    /// CLEAN OCR
    return TextCleaner.clean(buffer.toString());
  }

}
