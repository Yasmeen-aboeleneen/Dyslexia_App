// ignore_for_file: prefer_final_fields, avoid_print, deprecated_member_use

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'spelling_test_model.dart';

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
  bool _speechInitialized = false;
  bool _ttsInitialized = false;
  double _speechConfidence = 0.0;

  SpellingTestController({SpellingTestModel? model})
      : _model = model ?? SpellingTestModel();

  // Getters
  SpellingWord get currentWord => _model.currentWord;
  int get score => _model.score;
  int get attempts => _model.attempts;
  int get currentIndex => _model.currentIndex;
  List<SpellingWord> get words => _model.words;
  RecordingState get recordingState => _recordingState;
  String get userPronunciation => _userPronunciation;
  double get speechConfidence => _speechConfidence;
  bool get isLastWord => _model.isLastWord;

  Future<void> initialize() async {
    try {
      await _initializeAudioServices();
    } catch (e) {
      throw Exception('Failed to initialize audio services: ${e.toString()}');
    }
  }

  Future<void> _initializeAudioServices() async {
    await _initializeTTS();
    await _initializeSpeechRecognition();
    await _initializeAudioRecorder();
    await _initializeAudioPlayer();
  }

  Future<void> _initializeTTS() async {
    await _tts.setLanguage('ar-SA');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _ttsInitialized = true;
  }

  Future<void> _initializeSpeechRecognition() async {
    _speechInitialized = await _speech.initialize(
      onStatus: (status) => print('Recognition status: $status'),
      onError: (error) => print('Recognition error: $error'),
    );
  }

  Future<void> _initializeAudioRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception('Microphone permission not granted');
    }
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  Future<void> _initializeAudioPlayer() async {
    await _player.openPlayer();
    await _player.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  Future<void> speakWord() async {
    if (!_ttsInitialized) return;
    await _tts.stop();
    await _tts.speak(currentWord.word);
  }

  Future<void> startRecording() async {
    if (!_speechInitialized || _recordingState != RecordingState.idle) return;

    _recordingState = RecordingState.recording;
    _model.incrementAttempts();
    _userPronunciation = '';
    _speechConfidence = 0.0;

    final dir = await getTemporaryDirectory();
    _recordingPath = '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

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

  String _cleanSpeechResult(String text) {
    return text
        .replaceAll(RegExp(r'[.,،]'), '')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .trim();
  }

  Future<PronunciationResult> stopRecording() async {
    if (_recordingState != RecordingState.recording) {
      return PronunciationResult(false, 0.0);
    }

    _recordingState = RecordingState.processing;
    await _recorder.stopRecorder();
    await _speech.stop();

    if (_userPronunciation.isEmpty) {
      _recordingState = RecordingState.idle;
      return PronunciationResult(false, 0.0);
    }

    final isCorrect = currentWord.matchesPronunciation(_userPronunciation);
    if (isCorrect) {
      _model.incrementScore();
    }

    _recordingState = RecordingState.idle;
    return PronunciationResult(isCorrect, _speechConfidence);
  }

  Future<void> playRecording() async {
    if (_recordingPath == null || _recordingState != RecordingState.idle) return;

    _recordingState = RecordingState.playing;
    await _player.startPlayer(
      fromURI: _recordingPath!,
      codec: Codec.aacADTS,
      whenFinished: () {
        _recordingState = RecordingState.idle;
      },
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
    _userPronunciation = '';
    _recordingPath = null;
    _speechConfidence = 0.0;
  }

  void resetTest() {
    // Reset model
    _model.reset();
    
    // Reset controller state
    _recordingState = RecordingState.idle;
    _userPronunciation = '';
    _recordingPath = null;
    _speechConfidence = 0.0;
    
    // Stop any ongoing audio operations
    _tts.stop();
    _speech.stop();
    if (_recorder.isRecording) _recorder.stopRecorder();
    if (_player.isPlaying) _player.stopPlayer();
  }

  Map<String, dynamic> getTestResults() {
    return {
      'totalWords': _model.words.length,
      'correctAnswers': _model.score,
      'successPercentage': (_model.score / _model.words.length * 100).round(),
      'date': DateTime.now().toIso8601String(),
    };
  }

  Future<void> dispose() async {
    await _tts.stop();
    await _speech.cancel();
    if (_recorder.isRecording) await _recorder.stopRecorder();
    if (_player.isPlaying) await _player.stopPlayer();
    await _recorder.closeRecorder();
    await _player.closePlayer();
  }
}

class PronunciationResult {
  final bool isCorrect;
  final double confidence;

  PronunciationResult(this.isCorrect, this.confidence);
}