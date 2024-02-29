// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4aRHzUdTPAOJZcBSSMXCMEpi2_I4c9UU',
    appId: '1:760830767299:web:37dc15c54cb1e54ecfb276',
    messagingSenderId: '760830767299',
    projectId: 'chat-gemini-8fef0',
    authDomain: 'chat-gemini-8fef0.firebaseapp.com',
    storageBucket: 'chat-gemini-8fef0.appspot.com',
    measurementId: 'G-20KYC1B7NF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAm3YYFerD4ejRkteyCnrcGqZ-sefXkLIk',
    appId: '1:760830767299:android:ff50f56fcbb85ab2cfb276',
    messagingSenderId: '760830767299',
    projectId: 'chat-gemini-8fef0',
    storageBucket: 'chat-gemini-8fef0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWKqJ8kuXx2WJxQUrOBpq19ptyFpZC7d8',
    appId: '1:760830767299:ios:68235459a7be1998cfb276',
    messagingSenderId: '760830767299',
    projectId: 'chat-gemini-8fef0',
    storageBucket: 'chat-gemini-8fef0.appspot.com',
    iosBundleId: 'com.zeenko.chatGemini',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWKqJ8kuXx2WJxQUrOBpq19ptyFpZC7d8',
    appId: '1:760830767299:ios:414f48688d1d88aecfb276',
    messagingSenderId: '760830767299',
    projectId: 'chat-gemini-8fef0',
    storageBucket: 'chat-gemini-8fef0.appspot.com',
    iosBundleId: 'com.example.chatGemini.RunnerTests',
  );
}
