# AI_NOTE_Final_Exam

# AI Note Scanner

AI Note Scanner เป็นแอปพลิเคชันที่พัฒนาด้วย Flutter สำหรับสแกนข้อความจากรูปภาพและบันทึกเป็นโน้ต โดยระบบสามารถใช้ AI เพื่อช่วยสรุปเนื้อหาของโน้ตโดยอัตโนมัติ

---

## Features

- Scan ข้อความจากรูปภาพด้วย OCR
- AI ช่วยแก้ไขข้อความจาก OCR
- AI สรุปเนื้อหาโน้ตอัตโนมัติ
- สร้าง Title ของโน้ตอัตโนมัติ
- บันทึกโน้ตลงใน SQLite Database
- ดูรายการโน้ตทั้งหมด
- ดูรายละเอียดโน้ต

---

# System Architecture

โปรเจกต์นี้ใช้แนวคิด **Clean Architecture** เพื่อแยกส่วนของระบบให้ชัดเจน

```
Presentation Layer
│
├── Pages
├── Widgets
└── BLoC

Domain Layer
│
└── Entities

Data Layer
│
├── Services
└── Database (SQLite)
```

### 1. Presentation Layer
เป็นส่วนของ UI และการแสดงผล เช่น

- Home Page
- Add Note Page
- Note Detail Page

รวมถึงการจัดการ State ของหน้าจอ

---

### 2. Domain Layer
เป็นส่วนของ Business Logic และ Entity ของระบบ เช่น

- Note Entity

---

### 3. Data Layer
เป็นส่วนที่ติดต่อกับข้อมูล เช่น

- SQLite Database
- OCR Service
- AI Service

---

# Project Structure

```
lib
│
├── core
│ └── database
│
├── features
│ └── notes
│ ├── data
│ ├── domain
│ └── presentation
│ ├── bloc
│ ├── pages
│ └── widgets
│
├── router
│
└── main.dart
```

# Installation Guide

## 1. Clone Repository

## 2. Install Dependencies 
flutter pub get

## 3. ตั้งค่า Environment Variables
สร้างไฟล์ `.env` 
- GEMINI_API_KEY=your_api_key

## 4. Run Application
flutter run -d android

# Testing

โปรเจกต์นี้มีการทดสอบ 3 ระดับ

### Unit Test
ทดสอบ Business Logic

### Widget Test
ทดสอบ UI

### Integration Test
ทดสอบการทำงานของระบบแบบ End-to-End

