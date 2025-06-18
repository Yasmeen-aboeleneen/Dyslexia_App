import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Widgets/custom_button.dart';
import 'package:dyslexia_app/Core/Widgets/custom_text_form_field.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/have_an_account.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/terms_and_conditions.dart';
import 'package:dyslexia_app/Views/Home/dyslexia_info_screen.dart';
import 'package:flutter/material.dart';

class SignupBodyScreen extends StatelessWidget {
  const SignupBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: h * .04,
            ),
            CustomTextFormField(
              hintText: 'الاسم كامل',
              textInputType: TextInputType.text,
              icon: Icon(
                Icons.person,
                color: kMGrey,
              ),
            ),
            SizedBox(
              height: h * .025,
            ),
            const CustomTextFormField(
              hintText: 'البريد الإلكتروني',
              textInputType: TextInputType.emailAddress,
              icon: Icon(
                Icons.mail,
                color: kMGrey,
              ),
            ),
            SizedBox(
              height: h * .025,
            ),
            const CustomTextFormField(
              icon: Icon(
                Icons.remove_red_eye,
                color: kMGrey,
              ),
              hintText: 'كلمة المرور',
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: h * .02,
            ),
            TermsAndConditions(),
            SizedBox(
              height: h * .033,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomButton(
                  onpressed: () {
                    Navigator.pushNamed(
                        context, DyslexiaInfoScreen.dyslexiaInfoRoute);
                  },
                  text: 'إنشاء حساب جديد'),
            ),
            SizedBox(
              height: h * .02,
            ),
            HaveAnAccount(w: w)
          ],
        ),
      ),
    );
  }
}
