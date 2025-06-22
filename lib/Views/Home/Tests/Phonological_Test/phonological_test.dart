// ignore_for_file: library_private_types_in_public_api

import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological_Test/Controller/phoneme_controller.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological_Test/exercise_card.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological_Test/phoneme_result_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PhonologicalTestScreen extends StatefulWidget {
  const PhonologicalTestScreen({super.key});

  @override
  _PhonologicalTestScreenState createState() => _PhonologicalTestScreenState();
}

class _PhonologicalTestScreenState extends State<PhonologicalTestScreen> {
  final PhonemeController _controller = PhonemeController();
  final FlutterTts _tts = FlutterTts();
  String? _userAnswer;
  bool _showFeedback = false;
  bool _isCorrect = false;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initTts();
    _speakCurrentExercise();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage("ar-SA");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);
  }

  Future<void> _speakCurrentExercise() async {
    setState(() => _isSpeaking = true);
    await _controller.speakExercise(_controller.currentExercise);
    setState(() => _isSpeaking = false);
  }

  Future<void> _speakFeedback(bool isCorrect, String correctAnswer) async {
    setState(() => _isSpeaking = true);
    if (isCorrect) {
      await _tts.speak("إجابة صحيحة! أحسنت!");
    } else {
      await _tts.speak("إجابة خاطئة. الجواب الصحيح هو $correctAnswer");
    }
    setState(() => _isSpeaking = false);
  }

  void _checkAnswer() {
    if (_userAnswer == null || _userAnswer!.isEmpty) return;

    setState(() {
      _isCorrect = _controller.checkAnswer(_userAnswer!);
      _showFeedback = true;
    });

    _speakFeedback(_isCorrect, _controller.currentExercise.correctAnswer);

    Future.delayed(const Duration(seconds: 5), () {
      if (_controller.moveToNext()) {
        setState(() {
          _userAnswer = null;
          _showFeedback = false;
        });
        _speakCurrentExercise();
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => ResultDialog(
        score: _controller.score,
        total: _controller.totalExercises,
        onRestart: _restartTest,
      ),
    );
  }

  void _restartTest() {
    setState(() {
      _controller.reset();
      _userAnswer = null;
      _showFeedback = false;
    });
    _speakCurrentExercise();
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = _controller.currentExercise;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimary3,
      appBar: BuildAppBar(context, w, title: ' التدريبات الصوتية', actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: _isSpeaking ? null : _speakCurrentExercise,
              tooltip: 'تكرار السؤال',
              icon: Icon(
                size: 25,
                _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
              )),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h * .05),
              LinearProgressIndicator(
                color: kBlack,
                backgroundColor: kveryWhite,
                value:
                    (_controller.currentIndex + 1) / _controller.totalExercises,
              ),
              SizedBox(height: h * .045),
              Text(
                'السؤال ${_controller.currentIndex + 1} من ${_controller.totalExercises}',
                style: GoogleFonts.cairo(
                    color: kveryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .06),
              ),
              SizedBox(height: h * .045),
              ExerciseCard(
                exercise: currentExercise,
                currentAnswer: _userAnswer,
                onAnswer: (answer) {
                  setState(() => _userAnswer = answer);
                  _checkAnswer();
                },
              ),
              if (_showFeedback)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: h * .09,
                    width: w * .85,
                    decoration: BoxDecoration(
                        color: kveryWhite,
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                      child: Text(
                        _isCorrect
                            ? 'إجابة صحيحة! 👍'
                            : 'إجابة خاطئة، الجواب الصحيح: ${currentExercise.correctAnswer}',
                        style: GoogleFonts.cairo(
                            color: _isCorrect ? kgreen : kRed,
                            fontSize: w * .04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
