import 'package:chat_gemini/utils/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Username Validation', () {
    test('Empty username returns error string', () {
      final result = usernameValidation('');
      expect(result, 'Username is required');
    });

    test('Null username returns error string', () {
      final result = usernameValidation(null);
      expect(result, 'Username is required');
    });

    test('Username with less than 3 characters returns error string', () {
      final result = usernameValidation('ab');
      expect(result, 'Username must be at least 3 characters');
    });

    test('Username with more than 20 characters returns error string', () {
      final result = usernameValidation('abcdefghijklmnopqrstuv');
      expect(result, 'Username must be at most 20 characters');
    });

    test('Valid username returns null', () {
      final result = usernameValidation('validusername');
      expect(result, null);
    });
  });

  group('Password Validation', () {
    test('Empty password returns error string', () {
      final result = passwordValidation('');
      expect(result, 'Password is required');
    });

    test('Null password returns error string', () {
      final result = passwordValidation(null);
      expect(result, 'Password is required');
    });

    test('Password with less than 6 characters returns error string', () {
      final result = passwordValidation('abcde');
      expect(result, 'Password must be at least 6 characters');
    });

    test('Valid password returns null', () {
      final result = passwordValidation('validpassword');
      expect(result, null);
    });
  });

  group('Confirm Password Validation', () {
    test('Empty confirm password returns error string', () {
      final result = confirmPasswordValidation('password', '');
      expect(result, 'Confirm password is required');
    });

    test('Null confirm password returns error string', () {
      final result = confirmPasswordValidation('password', null);
      expect(result, 'Confirm password is required');
    });

    test('Mismatching confirm password returns error string', () {
      final result = confirmPasswordValidation('password', 'password1');
      expect(result, 'Passwords do not match');
    });

    test('Matching confirm password returns null', () {
      final result = confirmPasswordValidation('password', 'password');
      expect(result, null);
    });
  });

  group('Email Validation', () {
    test('Empty email returns error string', () {
      final result = emailValidation('');
      expect(result, 'Email is required');
    });

    test('Null email returns error string', () {
      final result = emailValidation(null);
      expect(result, 'Email is required');
    });

    test('Invalid email returns error string', () {
      final result = emailValidation('invalidemail');
      expect(result, 'Invalid email');
    });

    test('Valid email returns null', () {
      final result = emailValidation('validemail@example.com');
      expect(result, null);
    });
  });

  group('Chat Name Validation', () {
    test('Empty chat name returns error string', () {
      final result = chatNameValidation('');
      expect(result, 'Name is required');
    });

    test('Null chat name returns error string', () {
      final result = chatNameValidation(null);
      expect(result, 'Name is required');
    });

    test('Chat name with less than 3 characters returns error string', () {
      final result = chatNameValidation('ab');
      expect(result, 'Name must be at least 3 characters');
    });

    test('Chat name with more than 20 characters returns error string', () {
      final result = chatNameValidation('abcdefghijklmnopqrstuv');
      expect(result, 'Name must be at most 20 characters');
    });

    test('Valid chat name returns null', () {
      final result = chatNameValidation('validchatname');
      expect(result, null);
    });
  });
}
