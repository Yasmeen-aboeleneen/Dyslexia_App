import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_A2Vu7R22LtsndcoSlmgLIZ85OeseQrs',
    appId: '1:903584646243:android:3802bf9600b2e183cee456',
    messagingSenderId: '903584646243',
    projectId: 'dyslexia-app-ab4d1',
    storageBucket: 'dyslexia-app-ab4d1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_A2Vu7R22LtsndcoSlmgLIZ85OeseQrs',
    appId: '1:903584646243:ios:3802bf9600b2e183cee456',
    messagingSenderId: '903584646243',
    projectId: 'dyslexia-app-ab4d1',
    storageBucket: 'dyslexia-app-ab4d1.firebasestorage.app',
    iosClientId: '',
    iosBundleId: 'com.example.dyslexia_app',
  );
}
