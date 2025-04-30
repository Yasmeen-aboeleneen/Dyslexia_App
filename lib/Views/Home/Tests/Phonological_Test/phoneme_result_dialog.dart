import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultDialog extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const ResultDialog({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (score / total) * 100;
    String feedback;
    Color color;

    if (percentage < 50) {
      feedback = 'يحتاج إلى تدريب مكثف على المهارات الصوتية';
      color = kRed;
    } else if (percentage < 75) {
      feedback = 'أداء مقبول ولكن يحتاج تحسين';
      color = kPrimary;
    } else {
      feedback = 'مهارات صوتية ممتازة!';
      color = kgreen2;
    }

    return AlertDialog(
      backgroundColor: kveryWhite,
      title: Center(
        child: Text(
          'نتائج اختبار الوعي الصوتي',
          style: GoogleFonts.cairo(
              color: kBlack, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'النتيجة: $score من $total',
            style: GoogleFonts.cairo(
                color: kBlack, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            color: color,
          ),
          const SizedBox(height: 20),
          Text(
            feedback,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      actions: [
        TextButton(
          style:
              ButtonStyle(backgroundColor: WidgetStatePropertyAll(kPrimary3)),
          onPressed: onRestart,
          child: Center(
            child: Text(
              'إعادة الاختبار',
              style: GoogleFonts.cairo(
                  color: kveryWhite, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
