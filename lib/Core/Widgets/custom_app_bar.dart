import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
AppBar BuildAppBar(
  context,
  double w, {
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    actions: actions ?? [],
    backgroundColor: kveryWhite,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: kBlack,
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.cairo(
        fontSize: w * .06,
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
