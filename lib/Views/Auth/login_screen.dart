import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_app_bar.dart';

import 'package:dyslexia_app/Views/Auth/Widgets/login_screen_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String loginRoute = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: BuildAppBar(context, w, title: 'تسجيل الدخول'),
        backgroundColor: kveryWhite,
        body: LoginScreenBody());
  }
}
