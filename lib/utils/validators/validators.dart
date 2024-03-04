String? usernameValidation(String? username) {
  if (username == null || username.isEmpty) {
    return 'Username is required';
  }
  if (username.isEmpty) {
    return 'Username is required';
  }
  if (username.length < 3) {
    return 'Username must be at least 3 characters';
  }
  if (username.length > 20) {
    return 'Username must be at most 20 characters';
  }
  return null;
}

String? passwordValidation(String? password) {
  if (password == null || password.isEmpty) {
    return 'Email is required';
  }

  if (password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? confirmPasswordValidation(String password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password is required';
  }
  if (confirmPassword != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? emailValidation(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }
  if (email.isEmpty) {
    return 'Email is required';
  }
  if (!email.contains('@')) {
    return 'Invalid email';
  }
  return null;
}

String? chatNameValidation(String? chatName) {
  if (chatName == null || chatName.isEmpty) {
    return 'Name is required';
  }
  if (chatName.isEmpty) {
    return 'Name is required';
  }
  if (chatName.length < 3) {
    return 'Name must be at least 3 characters';
  }
  if (chatName.length > 20) {
    return 'Name must be at most 20 characters';
  }
  return null;
}
