import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class TextDisplayCard extends StatelessWidget {
  final String text;

  const TextDisplayCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimary3, width: 3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
