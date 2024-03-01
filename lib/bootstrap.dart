import 'dart:async';

import 'package:chat_gemini/app/app.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

Future<void> bootstrap() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _firebaseInit();
      runApp(App());
    },
    _onError,
  );
}

void _onError(Object error, StackTrace stackTrace) {
  // if (_recordErrorToCrashlytics) {
  //   FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  // } else {
  //   Log().e('', error, stackTrace);
  // }
  Log().e(error, stackTrace);
}

// bool get _recordErrorToCrashlytics => !(kIsWeb || kDebugMode);

Future<void> _firebaseInit() async {
  final FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }

  // if (!kIsWeb && Platform.isWindows) {
  // await GoogleSignInDart(
  //   clientId:
  //       '406099696497-g5o9l0blii9970bgmfcfv14pioj90djd.apps.googleusercontent.com',
  // );
  // }
}
