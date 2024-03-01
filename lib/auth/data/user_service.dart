import 'package:chat_gemini/auth/models/user.dart';

class UserService {
  // ignore: unused_field
  final String _userId;

  UserService(this._userId);

  Future<User> getUser() async {
    // Fetch user from database
    throw UnimplementedError('getUser() is not implemented');
  }
}
