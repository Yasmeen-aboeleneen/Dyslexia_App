import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/signup_body_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String signUPRoute = 'signup';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kveryWhite,
      appBar: BuildAppBar(context, w, title: "انشاء حساب"),
      body: SignupBodyScreen(),
    );
  }
}
