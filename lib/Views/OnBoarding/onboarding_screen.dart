import 'package:dots_indicator/dots_indicator.dart';
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Constants/constants.dart';
import 'package:dyslexia_app/Core/Services/shared_preferences_singleton.dart';
import 'package:dyslexia_app/Views/Auth/login_screen.dart';
import 'package:dyslexia_app/Views/OnBoarding/Widgets/custom_button.dart';
import 'package:dyslexia_app/Views/OnBoarding/Widgets/on_boarding_page_view.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String onBoardingRoute = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  double currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kveryWhite,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: OnboardingPageView(
                pageController: pageController,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SafeArea(
            child: Column(
              children: [
                DotsIndicator(
                  dotsCount: 3,
                  position: currentPage,
                  decorator: DotsDecorator(
                    activeColor: kRed,
                    color: kGrey,
                  ),
                ),
                const SizedBox(height: 29),
                AnimatedOpacity(
                  opacity: currentPage == 2 ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomButton(
                      onpressed: () {
                        SharedPreferencesSingleton.setBool(
                            kIsOnBoardingScreenSeen, true);
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.loginRoute);
                      },
                      text: 'ابدأ الآن',
                    ),
                  ),
                ),
                const SizedBox(height: 43),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
