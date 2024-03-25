class ReauthenticateException implements Exception {
  const ReauthenticateException([this.message = 'User need to reauthenticate']);
  final String message;

  @override
  String toString() => message;
}
