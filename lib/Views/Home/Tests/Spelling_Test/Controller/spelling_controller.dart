import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:dyslexia_app/Views/Home/Tests/Spelling_Test/Model/spelling_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SpellingTestViewModel {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final SpellingTestModel _model = SpellingTestModel();
  final FlutterTts _tts = FlutterTts();

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isProcessing = false;
  bool _showResult = false;
  bool _isCorrect = false;
  String? _recordedFilePath;
  String _userPronunciation = '';
  bool _speechInitialized = false;

  // Getters
  List<SpellingWord> get words => _model.words;
  int get currentIndex => _model.currentIndex;
  int get score => _model.score;
  int get attempts => _model.attempts;
  bool get showHint => _model.showHint;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  bool get isProcessing => _isProcessing;
  bool get showResult => _showResult;
  bool get isCorrect => _isCorrect;
  String? get recordedFilePath => _recordedFilePath;
  String get userPronunciation => _userPronunciation;

  Future<void> init() async {
    await _initAudio();
    await _requestPermissions();
    _speechInitialized = await _speech.initialize();
    if (!_speechInitialized) {
      throw Exception('تعذر تهيئة خدمة التعرف على الصوت');
    }
  }

  Future<void> _initAudio() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
  }

  Future<void> _requestPermissions() async {
    final status = await [Permission.microphone, Permission.storage].request();
    if (status[Permission.microphone] != PermissionStatus.granted) {
      throw Exception('لم يتم منح إذن استخدام الميكروفون');
    }
  }

  Future<void> speakWord() async {
    await _player.stopPlayer();
    await _speech.cancel();
    await _tts.speak(_model.words[_model.currentIndex].word);
  }

  Future<void> startRecording() async {
    if (!_speechInitialized) return;

    _userPronunciation = '';
    setState(() {
      _isRecording = true;
      _showResult = false;
      _model.attempts++;
    });

    final dir = await getTemporaryDirectory();
    _recordedFilePath =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder.startRecorder(
      toFile: _recordedFilePath!,
      codec: Codec.aacADTS,
    );

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _userPronunciation = result.recognizedWords;
        }
      },
      localeId: 'ar-SA',
      listenMode: stt.ListenMode.confirmation,
      cancelOnError: true,
      partialResults: false,
    );
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;

    await _recorder.stopRecorder();
    await _speech.stop();

    setState(() => _isRecording = false);

    if (_userPronunciation.isNotEmpty) {
      await _evaluateRecording();
    } else {
      setState(() {
        _showResult = true;
        _isCorrect = false;
      });
    }
  }

  Future<void> _evaluateRecording() async {
    setState(() => _isProcessing = true);

    try {
      final currentWord = _model.words[_model.currentIndex];
      _isCorrect = _checkPronunciation(_userPronunciation, currentWord);

      if (_isCorrect) {
        _model.score++;
      }
    } catch (e) {
      _isCorrect = false;
    }

    setState(() {
      _isProcessing = false;
      _showResult = true;
    });
  }

  bool _checkPronunciation(String userInput, SpellingWord word) {
    // تنظيف المدخلات
    String cleanInput = userInput
        .trim()
        .replaceAll(' ', '')
        .replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');

    String cleanWord = word.word
        .trim()
        .replaceAll(' ', '')
        .replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');

     if (cleanInput == cleanWord) return true;

    for (var pronunciation in word.acceptablePronunciations) {
      String cleanPronunciation = pronunciation
          .trim()
          .replaceAll(' ', '')
          .replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');

      if (cleanInput == cleanPronunciation) {
        return true;
      }
    }

    return false;
  }

  Future<void> playRecording() async {
    if (_recordedFilePath == null || _isPlaying) return;

    try {
      setState(() => _isPlaying = true);
      await _player.startPlayer(
        fromURI: _recordedFilePath!,
        codec: Codec.aacADTS,
        whenFinished: () => setState(() => _isPlaying = false),
      );
    } catch (e) {
      setState(() => _isPlaying = false);
      rethrow;
    }
  }

  void nextWord() {
    setState(() {
      _showResult = false;
      _recordedFilePath = null;
      _userPronunciation = '';
      _model.attempts = 0;
      _model.showHint = false;

      if (_model.currentIndex < _model.words.length - 1) {
        _model.currentIndex++;
      }
    });
  }

  void toggleHint() {
    setState(() => _model.showHint = !_model.showHint);
  }

  Map<String, dynamic> getTestResults() {
    return {
      'total': _model.words.length,
      'correct': _model.score,
      'percentage': (_model.score / _model.words.length * 100).round(),
    };
  }

  void setState(VoidCallback fn) {
    fn();
  }

  Future<void> dispose() async {
    await _speech.cancel();
    await _tts.stop();
    if (_recorder.isRecording) await _recorder.stopRecorder();
    if (_player.isPlaying) await _player.stopPlayer();
    await _recorder.closeRecorder();
    await _player.closePlayer();
  }
}
