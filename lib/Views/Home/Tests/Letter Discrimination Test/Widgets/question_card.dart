import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/Home/Tests/Letter%20Discrimination%20Test/Model/voice_letter_test_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final VoidCallback onPlaySound;
  final bool isPlaying;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onPlaySound,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      height: h * .42,
      width: w * .5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(color: Colors.white, blurRadius: 65)],
        gradient: LinearGradient(colors: [Colors.white, Colors.white]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'انطق هذا الحرف:',
            style: GoogleFonts.cairo(
              fontSize: w * .05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: h * .02),
          Text(
            question.letter,
            style: GoogleFonts.cairo(
              fontSize: w * .2,
              color: kBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: h * .01),
          Text(
            question.hint,
            style: GoogleFonts.cairo(
              fontSize: w * .04,
              color: kDGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: h * .04),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                isPlaying ? Icons.volume_up : Icons.volume_up_outlined,
                size: 60,
                color: kBlue2,
              ),
              onPressed: isPlaying ? null : onPlaySound,
            ),
          ),
        ],
      ),
    );
  }
}
