import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {

  final Dio dio = Dio();

  String get apiUrl {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    return "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey";
  }

  /// CORE METHOD CALL GEMINI
  Future<String> _askAI(String prompt) async {

    try {

      final response = await dio.post(
        apiUrl,
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        },
      );

      final result =
          response.data['candidates'][0]['content']['parts'][0]['text'];

      return result ?? "";

    } catch (e) {

      return "";
    }
  }

  /// FIX OCR TEXT
  Future<String> fixOCR(String text) async {

    final prompt = """
ข้อความนี้มาจาก OCR ซึ่งอาจมีคำผิด

กรุณา:
- แก้คำภาษาอังกฤษที่ผิด
- ลบคำที่ไม่มีความหมาย
- จัดข้อความให้อ่านง่าย

$text
""";

    final result = await _askAI(prompt);

    return result.isEmpty ? text : result;
  }

  /// SUMMARY
  Future<String> summarize(String text) async {

    final prompt = """
แปลและสรุปข้อความต่อไปนี้เป็นภาษาไทย

เงื่อนไข:
- ใช้ bullet point
- สรุปเฉพาะประเด็นสำคัญ
- ไม่ต้องยาวเกินไป

$text
""";

    final result = await _askAI(prompt);

    return result.isEmpty ? "ไม่สามารถสรุปข้อความได้" : result;
  }

  /// GENERATE TITLE
  Future<String> generateTitle(String text) async {

    final prompt = """
สร้างหัวข้อสั้น ๆ เป็นภาษาไทยจากข้อความต่อไปนี้

เงื่อนไข:
- ไม่เกิน 6 คำ
- เข้าใจง่าย

$text
""";

    final result = await _askAI(prompt);

    return result.isEmpty ? "โน้ตใหม่" : result;
  }

}
