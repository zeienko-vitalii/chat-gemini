import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

typedef EmailAuthFormCallback = void Function({
  required String email,
  required String password,
});

class EmailAuthForm extends StatefulWidget {
  const EmailAuthForm({
    super.key,
    required this.isSignIn,
    required this.onPressed,
    this.isLoading = false,
  });

  final bool isSignIn;
  final bool isLoading;
  final EmailAuthFormCallback onPressed;

  @override
  State<EmailAuthForm> createState() => _EmailAuthFormState();
}

class _EmailAuthFormState extends State<EmailAuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              cursorColor: Theme.of(context).iconTheme.color,
              cursorRadius: const Radius.circular(2),
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.all(16.0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(20),
            TextFormField(
              controller: _passwordController,
              cursorColor: Theme.of(context).iconTheme.color,
              cursorRadius: const Radius.circular(2),
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: const EdgeInsets.all(16.0),
                suffixIcon: _EyeIconButton(
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
                controller: _confirmPasswordController,
                cursorColor: Theme.of(context).iconTheme.color,
                cursorRadius: const Radius.circular(2),
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  contentPadding: const EdgeInsets.all(16.0),
                  suffixIcon: _EyeIconButton(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
              ),
              onPressed: () {
                _isButtonPressed = true;
                setState(() {});

                widget.onPressed(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
              child: _isButtonPressed && widget.isLoading
                  ? const CupertinoActivityIndicator()
                  : Text(
                      widget.isSignIn ? 'Sign In' : 'Sign Up',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EyeIconButton extends StatelessWidget {
  const _EyeIconButton({
    required this.isVisible,
    required this.onPressed,
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
