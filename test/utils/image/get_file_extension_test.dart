import 'package:chat_gemini/utils/image/get_file_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getFileExtension', () {
    test('returns .jpg for a filename with a simple extension', () {
      expect(getFileExtension('photo.jpg'), '.jpg');
    });

    test(
      'returns .png for a filename with a simple extension, case insensitive',
      () {
        expect(getFileExtension('IMAGE.PNG'), '.png');
      },
    );

    test('returns the last extension for a filename with multiple dots', () {
      expect(getFileExtension('archive.tar.gz'), '.gz');
    });

    test('handles filenames without an extension', () {
      expect(getFileExtension('filename'), '.filename');
    });
  });

  group('imageMimeTypeByFilePath', () {
    test('returns image/jpg for a JPG file', () {
      expect(imageMimeTypeByFilePath('photo.jpg'), 'image/jpg');
    });

    test('returns image/png for a PNG file', () {
      expect(imageMimeTypeByFilePath('image.png'), 'image/png');
    });

    test('returns image/gif for a GIF file', () {
      expect(imageMimeTypeByFilePath('animation.gif'), 'image/gif');
    });

    test('returns image/webp for a WEBP file', () {
      expect(imageMimeTypeByFilePath('picture.webp'), 'image/webp');
    });

    test('returns correct MIME type for a file with uppercase extension', () {
      expect(imageMimeTypeByFilePath('PHOTO.JPG'), 'image/jpg');
    });
  });
}
