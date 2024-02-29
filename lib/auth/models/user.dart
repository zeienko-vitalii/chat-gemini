class User {
  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.photoURL,
    this.credits = 10,
  });

  final String uid;
  final String email;
  final String username;
  final String photoURL;
  final int credits;
}
