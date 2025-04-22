import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts flutterTts = FlutterTts();

  static Future<void> init() async {
    await flutterTts.setLanguage("ar-EG"); // تعيين اللغة العربية المصرية
    await flutterTts.setPitch(5.0); // ضبط درجة الصوت
    await flutterTts.setSpeechRate(0.6); // ضبط سرعة الكلام
  }

  static Future<void> speak(String text) async {
    await flutterTts.speak(text); // قراءة النص بصوت عالٍ
  }

  static Future<void> stop() async {
    await flutterTts.stop(); // إيقاف القراءة
  }
}
