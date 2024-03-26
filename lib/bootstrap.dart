import 'dart:async';
import 'dart:isolate';

import 'package:chat_gemini/app/app.dart';
import 'package:chat_gemini/di/di.dart';
import 'package:chat_gemini/firebase_options.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool shouldUseFirebaseEmulator = false;

Future<void> bootstrap() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await _firebaseInit();

      configureDependencies();

      _registerCrashlytics();

      runApp(App());
    },
    _onError,
  );
}

Future<void> _firebaseInit() async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instanceFor(app: app);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }
}

void _registerCrashlytics() {
  if (kIsWeb || kDebugMode) {
    return;
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Isolate.current.addErrorListener(
    RawReceivePort(
      (List<dynamic> pair) async {
        final errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last as StackTrace?,
          fatal: true,
        );
      },
    ).sendPort,
  );
}

void _onError(Object error, StackTrace stackTrace) {
  if (!kIsWeb || !kDebugMode) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  } else {
    Log().e(error, stackTrace);
  }
  Log().e(error, stackTrace);
}

// bool get _recordErrorToCrashlytics => !(kIsWeb || kDebugMode);
