// ignore_for_file: prefer_final_fields, deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ================ MODELS ================
class SpellingWord {
  final String word;
  final String? hint;
  final List<String> acceptablePronunciations;
  final List<String> commonMistakes;
  final String phoneticPattern;
  final int difficultyLevel;
  final double similarityThreshold;

  SpellingWord({
    required this.word,
    this.hint,
    this.acceptablePronunciations = const [],
    this.commonMistakes = const [],
    required this.phoneticPattern,
    this.difficultyLevel = 1,
    this.similarityThreshold = 0.7,
  });

  factory SpellingWord.fromJson(Map<String, dynamic> json) => SpellingWord(
        word: json['word'],
        hint: json['hint'],
        acceptablePronunciations:
            List<String>.from(json['acceptablePronunciations'] ?? []),
        commonMistakes: List<String>.from(json['commonMistakes'] ?? []),
        phoneticPattern: json['phoneticPattern'],
        difficultyLevel: json['difficultyLevel'] ?? 1,
        similarityThreshold: json['similarityThreshold']?.toDouble() ?? 0.7,
      );

  bool matchesPronunciation(String input) {
    final normalizedInput = _normalizeText(input);
    final normalizedWord = _normalizeText(word);

    // Direct match check
    if (normalizedInput == normalizedWord) return true;

    // Acceptable pronunciations check
    if (acceptablePronunciations
        .any((p) => _normalizeText(p) == normalizedInput)) {
      return true;
    }

    // Common mistakes check
    if (isCommonMistake(normalizedInput)) return false;

    // Advanced phonetic checks
    return _checkPhoneticSimilarity(normalizedInput) ||
        _checkSimilarity(normalizedInput, normalizedWord);
  }

  bool isCommonMistake(String input) =>
      commonMistakes.any((m) => _normalizeText(m) == input);

  bool _checkPhoneticSimilarity(String input) {
    final expectedPhonemes = phoneticPattern.split('-');
    final inputPhonemes = _normalizeText(input).split('');

    if (expectedPhonemes.length != inputPhonemes.length) return false;

    for (int i = 0; i < expectedPhonemes.length; i++) {
      if (!_phonemesMatch(expectedPhonemes[i], inputPhonemes[i])) {
        return false;
      }
    }
    return true;
  }

  bool _phonemesMatch(String expected, String actual) {
    const similarPhonemes = {
      'ق': ['ق', 'ك', 'ء'],
      'ج': ['ج', 'گ', 'ي'],
      'غ': ['غ', 'ق'],
      'ض': ['ض', 'ظ', 'د'],
    };
    return expected == actual ||
        (similarPhonemes[expected]?.contains(actual) ?? false);
  }

  bool _checkSimilarity(String input, String correct) {
    final distance = _levenshteinDistance(input, correct);
    final maxLength =
        input.length > correct.length ? input.length : correct.length;
    final similarity = 1.0 - (distance / maxLength);
    return similarity >= similarityThreshold;
  }

  int _levenshteinDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final cost = a[0] == b[0] ? 0 : 1;

    return [
      _levenshteinDistance(a.substring(1), b) + 1,
      _levenshteinDistance(a, b.substring(1)) + 1,
      _levenshteinDistance(a.substring(1), b.substring(1)) + cost
    ].reduce((min, current) => min < current ? min : current);
  }

  String _normalizeText(String text) => text
      .replaceAll(RegExp(r'[\u064B-\u065F\u0610-\u061A]'), '')
      .replaceAll('أ', 'ا')
      .replaceAll('إ', 'ا')
      .replaceAll('آ', 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي')
      .replaceAll('ؤ', 'ء')
      .replaceAll('ئ', 'ء')
      .trim()
      .toLowerCase();
}

class SpellingTestModel {
  final List<SpellingWord> words;
  int _currentIndex;
  int _score;
  int _attempts;
  bool _showHint;

  SpellingTestModel({
    List<SpellingWord>? words,
    int currentIndex = 0,
    int score = 0,
    int attempts = 0,
    bool showHint = false,
  })  : words = words ?? _defaultWords(),
        _currentIndex = currentIndex,
        _score = score,
        _attempts = attempts,
        _showHint = showHint;

  static List<SpellingWord> _defaultWords() => [
        SpellingWord(
          word: 'مياه',
          acceptablePronunciations: ['مياه'],
          commonMistakes: ['ماء', 'مياه'],
          phoneticPattern: "م-ي-ا-ه",
        ),
        SpellingWord(
          word: 'قلم',
          acceptablePronunciations: ['أقلام'],
          commonMistakes: ['ألم', 'كلم'],
          phoneticPattern: "ق-ل-م",
        ),
      ];

  // Getters
  SpellingWord get currentWord => words[_currentIndex];
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get attempts => _attempts;
  bool get showHint => _showHint;
  bool get isLastWord => _currentIndex >= words.length - 1;
  int get totalWords => words.length;

  // Methods
  void nextWord() {
    if (!isLastWord) {
      _currentIndex++;
      _attempts = 0;
      _showHint = false;
    }
  }

  void incrementScore() => _score++;
  void incrementAttempts() => _attempts++;
  void toggleHint() => _showHint = !_showHint;

  void reset() {
    _currentIndex = 0;
    _score = 0;
    _attempts = 0;
    _showHint = false;
  }

  Map<String, dynamic> toJson() => {
        'currentIndex': _currentIndex,
        'score': _score,
        'attempts': _attempts,
        'showHint': _showHint,
        'words': words.map((word) => word.toJson()).toList(),
      };
}

extension on SpellingWord {
  toJson() {}
}

// ================ CONTROLLER ================
enum RecordingState { idle, recording, processing, playing }

class SpellingTestController {
  SpellingTestModel _model;
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  RecordingState _recordingState = RecordingState.idle;
  String _userPronunciation = '';
  String? _recordingPath;
  bool _isSpeechInitialized = false;
  bool _isTtsInitialized = false;
  double _speechConfidence = 0.0;

  SpellingTestController({SpellingTestModel? model})
      : _model = model ?? SpellingTestModel();

  // Getters
  SpellingWord get currentWord => _model.currentWord;
  int get score => _model.score;
  int get attempts => _model.attempts;
  int get currentIndex => _model.currentIndex;
  List<SpellingWord> get words => _model.words;
  bool get isLastWord => _model.isLastWord;
  RecordingState get recordingState => _recordingState;
  String get userPronunciation => _userPronunciation;
  double get speechConfidence => _speechConfidence;
  bool get showHint => _model.showHint;

  Future<void> initialize() async {
    try {
      await Future.wait([
        _initializeTTS(),
        _initializeSpeechRecognition(),
        _initializeAudioRecorder(),
        _initializeAudioPlayer(),
      ]);
    } catch (e) {
      throw Exception('فشل في تهيئة الخدمات الصوتية: $e');
    }
  }

  Future<void> _initializeTTS() async {
    await _tts.setLanguage('ar-SA');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _isTtsInitialized = true;
  }

  Future<void> _initializeSpeechRecognition() async {
    _isSpeechInitialized = await _speech.initialize(
      onStatus: (status) => debugPrint('حالة التعرف: $status'),
      onError: (error) => debugPrint('خطأ التعرف: $error'),
    );
  }

  Future<void> _initializeAudioRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) throw Exception('لم يتم منح إذن الميكروفون');
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  Future<void> _initializeAudioPlayer() async {
    await _player.openPlayer();
    await _player.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  Future<void> speakWord() async {
    if (!_isTtsInitialized) return;
    await _tts.stop();
    await _tts.speak(currentWord.word);
  }

  Future<void> startRecording() async {
    if (!_isSpeechInitialized || _recordingState != RecordingState.idle) return;

    _recordingState = RecordingState.recording;
    _model.incrementAttempts();
    _userPronunciation = '';
    _speechConfidence = 0.0;

    final dir = await getTemporaryDirectory();
    _recordingPath =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder.startRecorder(
      toFile: _recordingPath!,
      codec: Codec.aacADTS,
    );

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _userPronunciation = _cleanSpeechResult(result.recognizedWords);
          _speechConfidence = result.confidence;
        }
      },
      localeId: 'ar-SA',
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
    );
  }

  String _cleanSpeechResult(String text) => text
      .replaceAll(RegExp(r'[.,،]'), '')
      .replaceAll('أ', 'ا')
      .replaceAll('إ', 'ا')
      .replaceAll('آ', 'ا')
      .replaceAll('ة', 'ه')
      .trim();

  Future<PronunciationResult> stopRecording() async {
    if (_recordingState != RecordingState.recording) {
      return PronunciationResult(false, 0.0);
    }

    _recordingState = RecordingState.processing;
    await Future.wait([_recorder.stopRecorder(), _speech.stop()]);

    if (_userPronunciation.isEmpty) {
      _recordingState = RecordingState.idle;
      return PronunciationResult(false, 0.0);
    }

    final isCorrect = currentWord.matchesPronunciation(_userPronunciation);
    if (isCorrect) _model.incrementScore();

    _recordingState = RecordingState.idle;
    return PronunciationResult(isCorrect, _speechConfidence);
  }

  Future<void> playRecording() async {
    if (_recordingPath == null || _recordingState != RecordingState.idle)
      return;

    _recordingState = RecordingState.playing;
    await _player.startPlayer(
      fromURI: _recordingPath!,
      codec: Codec.aacADTS,
      whenFinished: () => _recordingState = RecordingState.idle,
    );
  }

  Future<void> stopPlaying() async {
    if (_recordingState == RecordingState.playing) {
      await _player.stopPlayer();
      _recordingState = RecordingState.idle;
    }
  }

  void nextWord() {
    _model.nextWord();
    _resetRecordingState();
  }

  void toggleHint() => _model.toggleHint();

  void resetTest() {
    _model.reset();
    _resetRecordingState();
    _stopAllAudio();
  }

  void _resetRecordingState() {
    _userPronunciation = '';
    _recordingPath = null;
    _speechConfidence = 0.0;
  }

  Future<void> _stopAllAudio() async {
    await Future.wait([
      _tts.stop(),
      _speech.stop(),
      if (_recorder.isRecording) _recorder.stopRecorder(),
      if (_player.isPlaying) _player.stopPlayer(),
    ]);
  }

  Map<String, dynamic> getTestResults() => {
        'totalWords': _model.words.length,
        'correctAnswers': _model.score,
        'successPercentage': (_model.score / _model.words.length * 100).round(),
        'date': DateTime.now().toIso8601String(),
      };

  Future<void> dispose() async {
    await _stopAllAudio();
    await Future.wait([
      _recorder.closeRecorder(),
      _player.closePlayer(),
    ]);
  }
}

class PronunciationResult {
  final bool isCorrect;
  final double confidence;

  const PronunciationResult(this.isCorrect, this.confidence);
}
