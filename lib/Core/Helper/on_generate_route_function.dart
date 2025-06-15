import 'package:dyslexia_app/Views/Auth/login_screen.dart';
import 'package:dyslexia_app/Views/Auth/signup_screen.dart';
import 'package:dyslexia_app/Views/OnBoarding/onboarding_screen.dart';
import 'package:dyslexia_app/Views/Splash/splash_screen.dart';
import 'package:dyslexia_app/Views/Splash/splash_screen1.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen1.routeName1:
      return MaterialPageRoute(builder: (context) => const SplashScreen1());
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case OnboardingScreen.onBoardingRoute:
      return MaterialPageRoute(builder: (context) => const OnboardingScreen());
    case LoginScreen.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SignupScreen.signUPRoute:
      return MaterialPageRoute(builder: (context) => const SignupScreen());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
