import 'package:chat_gemini/utils/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef EmailAuthFormCallback = void Function({
  required String email,
  required String password,
});

class EmailAuthForm extends StatefulWidget {
  const EmailAuthForm({
    required this.isSignIn,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.emailController,
    this.passwordController,
  });

  final bool isSignIn;
  final bool isLoading;
  final EmailAuthFormCallback? onPressed;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  State<EmailAuthForm> createState() => _EmailAuthFormState();
}

class _EmailAuthFormState extends State<EmailAuthForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  TextEditingController get _safeEmailController =>
      widget.emailController ?? _emailController;
  TextEditingController get _safePasswordController =>
      widget.passwordController ?? _passwordController;

  bool _isButtonPressed = false;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.isLoading && _isButtonPressed) {
      _isButtonPressed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: const Key('email_text_field'),
              controller: _safeEmailController,
              cursorColor: Theme.of(context).iconTheme.color,
              cursorRadius: const Radius.circular(2),
              validator: emailValidation,
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.all(16),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(20),
            TextFormField(
              key: const Key('password_text_field'),
              controller: _safePasswordController,
              cursorColor: Theme.of(context).iconTheme.color,
              cursorRadius: const Radius.circular(2),
              obscureText: !_isPasswordVisible,
              validator: passwordValidation,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: EyeIconButton(
                  isVisible: _isPasswordVisible,
                  onPressed: () {
                    _isPasswordVisible = !_isPasswordVisible;
                    setState(() {});
                  },
                ),
              ),
            ),
            if (!widget.isSignIn) ...[
              const Gap(20),
              TextFormField(
                key: const Key('confirm_password_text_field'),
                controller: _confirmPasswordController,
                cursorColor: Theme.of(context).iconTheme.color,
                cursorRadius: const Radius.circular(2),
                obscureText: !_isConfirmPasswordVisible,
                validator: (String? confirmPassword) =>
                    confirmPasswordValidation(
                  _safePasswordController.text,
                  confirmPassword,
                ),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: EyeIconButton(
                    isVisible: _isConfirmPasswordVisible,
                    onPressed: () {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
            const Gap(20),
            if (widget.onPressed != null)
              EmailSignInButton(
                isLoading: isButtonLoading(),
                isSignIn: widget.isSignIn,
                onSignInPressed: onSignInPressed,
              ),
          ],
        ),
      ),
    );
  }

  bool isButtonLoading() {
    return widget.isLoading && _isButtonPressed;
  }

  @visibleForTesting
  void onSignInPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _isButtonPressed = true;
      setState(() {});

      widget.onPressed?.call(
        email: _safeEmailController.text,
        password: _safePasswordController.text,
      );
    }
  }
}

@visibleForTesting
class EyeIconButton extends StatelessWidget {
  const EyeIconButton({
    required this.isVisible,
    required this.onPressed,
    super.key,
  });

  final bool isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isVisible
          ? const Icon(Icons.visibility_rounded)
          : const Icon(Icons.visibility_off_rounded),
      onPressed: onPressed,
    );
  }
}

class EmailSignInButton extends StatelessWidget {
  const EmailSignInButton({
    required this.isLoading,
    required this.isSignIn,
    required this.onSignInPressed,
    super.key,
  });

  final VoidCallback onSignInPressed;
  final bool isLoading;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
      ),
      onPressed: onSignInPressed,
      child: isLoading
          ? CupertinoActivityIndicator(
              color: Theme.of(context).colorScheme.surface,
            )
          : Text(
              emailSignInButtonTitle(
                isSignIn: isSignIn,
              ),
            ),
    );
  }
}

String emailSignInButtonTitle({required bool isSignIn}) {
  return isSignIn ? 'Sign In' : 'Sign Up';
}
