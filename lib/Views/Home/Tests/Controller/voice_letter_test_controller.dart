// ignore_for_file: avoid_print

import 'package:dyslexia_app/Views/Home/Tests/Models/voice_letter_test_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceLetterTestController {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  List<Question> questions = [
    Question(
      letter: 'ب',
      hint: 'قل "ب" مثل "باب"',
      similarLetters: ['ت', 'ث', 'ن'],
    ),
    Question(
      letter: 'ت',
      hint: 'قل "ت" مثل "توت"',
      similarLetters: ['ب', 'ث', 'ط'],
    ),
    Question(
      letter: 'ث',
      hint: 'قل "ث" مثل "ثوب"',
      similarLetters: ['ت', 'س', 'ذ'],
    ),
  ];

  Future<void> initTTS() async {
    await _tts.setLanguage("ar-SA");
    await _tts.setSpeechRate(0.4);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<bool> initSpeech() async {
    return await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );
  }

  Future<void> playLetterSound(String letter) async {
    await _tts.stop();
    await _tts.speak(letter);
  }

  Future<bool> requestMicrophonePermission() async {
    if (!await Permission.microphone.isGranted) {
      final status = await Permission.microphone.request();
      return status.isGranted;
    }
    return true;
  }

  Future<void> startListening({
    required void Function(String text) onResult,
    required void Function(String error) onError,
  }) async {
    if (_isListening) return;

    _isListening = true;
    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _isListening = false;
          onResult(processArabicText(result.recognizedWords));
        }
      },
      localeId: 'ar-SA',
      listenFor: Duration(seconds: 5),
      cancelOnError: true,
      partialResults: true,
    );
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    await _speech.stop();
    _isListening = false;
  }

  String processArabicText(String text) {
    return text
        .replaceAll('ة', 'ه')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('ـ', '')
        .trim();
  }

  bool checkAnswer(String input, Question question) {
    final possibleAnswers = [
      question.letter,
      _getLetterName(question.letter),
      ..._getSimilarPronunciations(question.letter),
      ...question.similarLetters, // Include similar letters for common mistakes
    ];

    return possibleAnswers.any((answer) =>
        input.contains(answer) || _getLetterName(answer).contains(input));
  }

  List<String> _getSimilarPronunciations(String letter) {
    switch (letter) {
      case 'ب':
        return ['ب', 'باه', 'بي'];
      case 'ت':
        return ['ت', 'تاه', 'تي'];
      case 'ث':
        return ['ث', 'ثاه', 'ثي'];
      default:
        return [];
    }
  }

  String _getLetterName(String letter) {
    const letterNames = {
      'أ': 'ألف',
      'ب': 'باء',
      'ت': 'تاء',
      'ث': 'ثاء',
      'ج': 'جيم',
      'ح': 'حاء',
      'خ': 'خاء',
      'د': 'دال',
      'ذ': 'ذال',
      'ر': 'راء',
      'ز': 'زاي',
      'س': 'سين',
      'ش': 'شين',
      'ص': 'صاد',
      'ض': 'ضاد',
      'ط': 'طاء',
      'ظ': 'ظاء',
      'ع': 'عين',
      'غ': 'غين',
      'ف': 'فاء',
      'ق': 'قاف',
      'ك': 'كاف',
      'ل': 'لام',
      'م': 'ميم',
      'ن': 'نون',
      'ه': 'هاء',
      'و': 'واو',
      'ي': 'ياء'
    };
    return letterNames[letter] ?? letter;
  }

  void dispose() {
    _tts.stop();
    _speech.stop();
  }
}
