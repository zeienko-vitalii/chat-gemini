// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show HttpRequest;

Future<dynamic> downloadBlobImageFromUrl(String url) async {
  final request = await HttpRequest.request(url, responseType: 'blob');
  return request.response;
}
