// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.text,
    required this.colors,
  });
  final String text;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: h * .12,
        width: w * .6,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: GoogleFonts.cairo(
                fontSize: w * .04, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
