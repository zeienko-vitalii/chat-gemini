class UserNotFoundException implements Exception {
  const UserNotFoundException([this.message = 'User not found']);
  final String message;

  @override
  String toString() => message;
}
