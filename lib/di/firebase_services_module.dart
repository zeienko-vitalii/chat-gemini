import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

@module
abstract class AuthModule {
  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firestoreInstance => FirebaseFirestore.instance;

  @singleton
  FirebaseStorage get storage => FirebaseStorage.instance;

  @singleton
  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: scopes,
      );
}
