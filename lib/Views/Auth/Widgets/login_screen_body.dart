// ignore_for_file: use_build_context_synchronously

import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Services/auth_service.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Core/Widgets/custom_button.dart';
import 'package:dyslexia_app/Core/Widgets/custom_text_form_field.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/dont_have_acc.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/or_divider.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/social_button.dart';
import 'package:dyslexia_app/Views/Home/dyslexia_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: h * .04),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'البريد الإلكتروني',
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: h * .025),
            CustomTextFormField(
              controller: _passwordController,
              icon: IconButton(
                icon: Icon(
                  _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  color: kMGrey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                },
              ),
              hintText: 'كلمة المرور',
              obscureText: _isPasswordHidden,
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: h * .02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'نسيت كلمة المرور؟',
                textAlign: TextAlign.left,
                style: GoogleFonts.cairo(
                  color: kBlack,
                  fontSize: w * .05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: h * .033),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomButton(
                onpressed: () async {
                  final user = await _authService.signInWithEmail(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
                    );
                    Navigator.pushReplacementNamed(
                        context, DyslexiaInfoScreen.dyslexiaInfoRoute);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل في تسجيل الدخول')),
                    );
                  }
                },
                text: 'تسجيل',
              ),
            ),
            SizedBox(height: h * .033),
            DontHaveAnAccountWidget(w: w),
            SizedBox(height: h * .033),
            const OrDivider(),
            SizedBox(height: h * .016),
            SocialButton(
              onpressed: () async {
                final user = await _authService.signInWithGoogle();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم تسجيل الدخول بجوجل')),
                  );
                  Navigator.pushReplacementNamed(
                      context, DyslexiaInfoScreen.dyslexiaInfoRoute);
                }
              },
              title: 'تسجيل بواسطة جوجل',
              image: Assets.imagesGoogleIcon,
            ),
            SizedBox(height: h * .033),
            SocialButton(
              onpressed: () async {
                final user = await _authService.signInWithApple();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم تسجيل الدخول بآبل')),
                  );
                  Navigator.pushReplacementNamed(
                      context, DyslexiaInfoScreen.dyslexiaInfoRoute);
                }
              },
              title: 'تسجيل بواسطة ابل',
              image: Assets.imagesApplIcon,
            ),
            SizedBox(height: h * .033),
            SocialButton(
              onpressed: () async {
                final user = await _authService.signInWithFacebook();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم تسجيل الدخول بفيسبوك')),
                  );
                  Navigator.pushReplacementNamed(
                      context, DyslexiaInfoScreen.dyslexiaInfoRoute);
                }
              },
              title: 'تسجيل بواسطة فيسبوك',
              image: Assets.imagesFacebookIcon,
            ),
            SizedBox(height: h * .033),
          ],
        ),
      ),
    );
  }
}
