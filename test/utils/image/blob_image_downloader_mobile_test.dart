import 'package:chat_gemini/utils/image/blob_image_downloader_mobile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('downloadBlobImageFromUrl', () {
    test('returns null as it is a stub for non-web platforms', () async {
      final result = await downloadBlobImageFromUrl(
        'http://example.com/image.png',
      );
      expect(result, isNull);
    });
  });
}
