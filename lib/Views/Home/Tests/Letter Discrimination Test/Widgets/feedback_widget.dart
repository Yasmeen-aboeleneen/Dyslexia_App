import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  final String text;
  final Color color;

  const FeedbackWidget({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(15),
      height: h * .07,
      width: w * .8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * .05,
            color: color == kgreen ? kBlack : kveryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
