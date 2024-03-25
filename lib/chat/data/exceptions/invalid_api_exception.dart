class InvalidApiException implements Exception {
  InvalidApiException([this.message = 'API key is empty']);

  final String message;
}
