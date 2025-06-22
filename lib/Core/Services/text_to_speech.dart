import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts flutterTts = FlutterTts();

  static Future<void> init() async {
    await flutterTts.setLanguage("ar-EG"); 
    await flutterTts.setPitch(5.0); 
    await flutterTts.setSpeechRate(0.6); 
  }

  static Future<void> speak(String text) async {
    await flutterTts.speak(text); 
  }

  static Future<void> stop() async {
    await flutterTts.stop(); 
  }
}
