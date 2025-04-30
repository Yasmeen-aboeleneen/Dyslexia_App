import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Tests/Phonological%20Test/Model/test_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseCard extends StatefulWidget {
  final PhonemeExercise exercise;
  final Function(String) onAnswer;
  final String? currentAnswer;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onAnswer,
    this.currentAnswer, 
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentAnswer ?? '');
  }

  @override
  void didUpdateWidget(ExerciseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise != widget.exercise) {
      _controller.text = widget.currentAnswer ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      height: h * .3,
      width: w * .85,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 70, color: kveryWhite)],
          color: kveryWhite,
          borderRadius: BorderRadius.circular(35)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: h * .02),
            Center(
              child: Text(widget.exercise.instruction,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                      color: kBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: w * .055)),
            ),
            SizedBox(height: h * .04),
            _buildAnswerInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerInput() {
    switch (widget.exercise.type) {
      case ExerciseType.BLENDING:
      case ExerciseType.DELETION:
      case ExerciseType.SUBSTITUTION:
        return TextFormField(
          controller: _controller, // استخدام الـ Controller
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: kPrimary3)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: kPrimary3)),
            labelText: 'أدخل إجابتك',
            labelStyle:
                GoogleFonts.cairo(color: kDGrey, fontWeight: FontWeight.w700),
            border: OutlineInputBorder(),
          ),
          onFieldSubmitted: widget.onAnswer,
        );
      case ExerciseType.RHYMING:
        return Column(
          children: widget.exercise.options!
              .map((option) => ElevatedButton(
                    onPressed: () => widget.onAnswer(option),
                    child: Text(option),
                  ))
              .toList(),
        );
      default:
        return const SizedBox();
    }
  }
}