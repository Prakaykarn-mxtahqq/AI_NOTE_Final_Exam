class TextCleaner {

  static String clean(String text) {

    String cleaned = text;

    // ลบ symbol แปลก
    cleaned = cleaned.replaceAll(RegExp(r'[^\w\sก-๙.,:/()-]'), '');

    // ลบตัวอักษรที่ยาวเกิน (noise OCR)
    cleaned = cleaned.replaceAll(RegExp(r'\b[a-zA-Z]{12,}\b'), '');

    // ลบช่องว่างซ้ำ
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ');

    return cleaned.trim();
  }

}
