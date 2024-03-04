import 'package:chat_gemini/utils/image/supported_image_mime_types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SupportedMimeTypes', () {
    test('imageJpeg returns correct MIME type', () {
      expect(SupportedMimeTypes.imageJpeg.name, 'image/jpeg');
    });

    test('imageJpg returns correct MIME type', () {
      expect(SupportedMimeTypes.imageJpg.name, 'image/jpg');
    });

    test('imagePng returns correct MIME type', () {
      expect(SupportedMimeTypes.imagePng.name, 'image/png');
    });

    test('imageGif returns correct MIME type', () {
      expect(SupportedMimeTypes.imageGif.name, 'image/gif');
    });

    test('imageWebp returns correct MIME type', () {
      expect(SupportedMimeTypes.imageWebp.name, 'image/webp');
    });
  });
}
