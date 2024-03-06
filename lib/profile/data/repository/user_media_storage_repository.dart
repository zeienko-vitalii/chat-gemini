import 'dart:io';

import 'package:chat_gemini/utils/image/blob_image_downloader_mobile.dart'
    if (dart.library.html) 'package:chat_gemini/utils/image/blob_image_downloader_web.dart'
    as blob_downloader;
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserMediaStorageRepository {
  UserMediaStorageRepository(this.storage);

  final FirebaseStorage storage;

  static const String _users = 'users';

  Reference _referenceById(String userId) => storage.ref(_users).child(userId);

  Future<void> deleteFiles(String userId) async {
    try {
      final data = await _referenceById(userId).listAll();
      if (data.items.isNotEmpty) {
        await _referenceById(userId).delete();
      }
    } catch (e) {
      Log().e('Failed to delete chat files: $e');
    }
  }

  Future<List<String>> fetchImageUrls(String userId) async {
    try {
      final result = await _referenceById(userId).listAll();
      final downloadablePath = await Future.wait<String>(
        result.items.map<Future<String>>(
          (Reference ref) => ref.getDownloadURL(),
        ),
      );
      return downloadablePath;
    } catch (e) {
      return <String>[];
    }
  }

  Future<String> uploadFile(
    String userId,
    String filePath, [
    String? fileName,
  ]) async {
    final snapshot = await _uploadImageTaskSnapshot(
      userId,
      filePath,
      fileName: fileName,
    );

    return snapshot.ref.getDownloadURL();
  }

  Future<TaskSnapshot> _uploadImageTaskSnapshot(
    String userId,
    String filePath, {
    String? fileName,
  }) async {
    try {
      final imageRef = _referenceById(userId);
      final imageName = fileName ?? filePath.split('/').last;
      final ref = imageRef.child(imageName);

      Log().i('Uploading image $imageName to $ref');
      if (kIsWeb) {
        final dynamic blob = blob_downloader.downloadBlobImageFromUrl(filePath);
        return ref.putBlob(blob);
      } else {
        return ref.putFile(
          File(filePath),
        );
      }
    } on FirebaseException catch (e, s) {
      Log().e('Failed to upload image: $e', s);
      rethrow;
    }
  }
}
