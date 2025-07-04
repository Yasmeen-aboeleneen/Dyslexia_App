 import 'package:dyslexia_app/Core/Helper/on_generate_route_function.dart';
 
import 'package:dyslexia_app/Core/Services/shared_preferences_singleton.dart';
import 'package:dyslexia_app/Core/Services/text_to_speech.dart';
import 'package:dyslexia_app/Views/Splash/splash_screen1.dart';
import 'package:dyslexia_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
 
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
   if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  await TextToSpeech.init();
  await SharedPreferencesSingleton.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      title: '',
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen1.routeName1,
    );
  }
}
