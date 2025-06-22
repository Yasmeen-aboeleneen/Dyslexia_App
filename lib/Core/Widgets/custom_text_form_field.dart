import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.icon,
    this.controller,
    this.obscureText = false,
    this.validator,
  });

  final String hintText;
  final TextInputType textInputType;
  final Widget? icon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: GoogleFonts.cairo(
          color: kDdGrey,
          fontSize: w * .038,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: kGrey,
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: kGrey, width: 1),
    );
  }
}
