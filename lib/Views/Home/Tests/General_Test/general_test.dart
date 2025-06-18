// ignore_for_file: library_private_types_in_public_api

import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:dyslexia_app/Views/Home/Tests/General_Test/Models/reading_model.dart';
import 'package:dyslexia_app/Views/Home/Tests/General_Test/Widgets/control_buttons.dart';
import 'package:dyslexia_app/Views/Home/Tests/General_Test/Widgets/result_display.dart';
import 'package:dyslexia_app/Views/Home/Tests/General_Test/Widgets/text_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ReadingTestPage extends StatefulWidget {
  const ReadingTestPage({super.key});

  @override
  _ReadingTestPageState createState() => _ReadingTestPageState();
}

class _ReadingTestPageState extends State<ReadingTestPage> {
  final FlutterTts flutterTts = FlutterTts();
  final SpeechToText speechToText = SpeechToText();

  final String originalText =
      "في أحد الأيام الجميلة، ذهب الطفل إلى الحديقة للعب مع أصدقائه.";
  String recognizedText = '';
  String result = '';
  bool isListening = false;

  Future<void> speak() async {
    await flutterTts.setLanguage("ar");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(originalText);
  }

  Future<void> startListening() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() {
        isListening = true;
        recognizedText = '';
      });
      speechToText.listen(onResult: (result) {
        setState(() {
          recognizedText = result.recognizedWords;
        });
      });
    }
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  void evaluateReading() {
    double similarity =
        ReadingEvaluator.calculateSimilarity(originalText, recognizedText);
    result = ReadingEvaluator.getLevel(similarity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kveryWhite,
      appBar: BuildAppBar(context, w, title: 'اختبار تحديد مستوي القراءة'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("اقرأ النص التالي:",
                style: GoogleFonts.notoNaskhArabic(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            TextDisplayCard(text: originalText),
            SizedBox(height: 16),
            ControlButtons(
              onSpeak: speak,
              onRecord: isListening ? stopListening : startListening,
              isListening: isListening,
            ),
            SizedBox(height: 20),
            ResultDisplay(
              recognizedText: recognizedText,
              result: result,
              onEvaluate: evaluateReading,
            ),
          ],
        ),
      ),
    );
  }
}
