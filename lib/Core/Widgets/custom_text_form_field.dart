import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      this.icon});
  final String hintText;
  final TextInputType textInputType;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hintText,
          hintStyle: GoogleFonts.cairo(
              color: kMGrey, fontSize: w * .038, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: kGrey,
          border: BuildBorder(),
          enabledBorder: BuildBorder(),
          focusedBorder: BuildBorder()),
    );
  }

  // ignore: non_constant_identifier_names
  OutlineInputBorder BuildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: kGrey, width: 1),
    );
  }
}
