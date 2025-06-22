// ignore_for_file: use_build_context_synchronously

import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Services/auth_service.dart';
import 'package:dyslexia_app/Core/Widgets/custom_button.dart';
import 'package:dyslexia_app/Core/Widgets/custom_text_form_field.dart';

import 'package:dyslexia_app/Views/Auth/Widgets/have_an_account.dart';
import 'package:dyslexia_app/Views/Auth/Widgets/terms_and_conditions.dart';
import 'package:dyslexia_app/Views/Home/dyslexia_info_screen.dart';
import 'package:flutter/material.dart';

class SignupBodyScreen extends StatefulWidget {
  const SignupBodyScreen({super.key});

  @override
  State<SignupBodyScreen> createState() => _SignupBodyScreenState();
}

class _SignupBodyScreenState extends State<SignupBodyScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordHidden = true;

  final AuthService _authService = AuthService();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final user = await _authService.signUpWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushNamed(context, DyslexiaInfoScreen.dyslexiaInfoRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء إنشاء الحساب')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: h * .04),
              CustomTextFormField(
                controller: _nameController,
                hintText: 'الاسم كامل',
                textInputType: TextInputType.text,
                icon: const Icon(Icons.person, color: kMGrey),
                validator: (val) => val!.trim().isEmpty ? 'أدخل الاسم' : null,
              ),
              SizedBox(height: h * .025),
              CustomTextFormField(
                controller: _emailController,
                hintText: 'البريد الإلكتروني',
                textInputType: TextInputType.emailAddress,
                icon: const Icon(Icons.mail, color: kMGrey),
                validator: (val) => val!.contains('@') && val.contains('.')
                    ? null
                    : 'بريد غير صالح',
              ),
              SizedBox(height: h * .025),
              CustomTextFormField(
                controller: _passwordController,
                hintText: 'كلمة المرور',
                obscureText: _isPasswordHidden,
                textInputType: TextInputType.visiblePassword,
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
                validator: (val) =>
                    val!.length < 6 ? 'كلمة المرور قصيرة' : null,
              ),
              SizedBox(height: h * .02),
              const TermsAndConditions(),
              SizedBox(height: h * .033),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        onpressed: _register,
                        text: 'إنشاء حساب جديد',
                      ),
              ),
              SizedBox(height: h * .02),
              HaveAnAccount(w: w),
            ],
          ),
        ),
      ),
    );
  }
}
