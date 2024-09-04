import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/views/logout/logout_dialog.dart';
import 'package:chat_gemini/profile/cubit/profile_cubit.dart';
import 'package:chat_gemini/profile/view/dialogs/reauthenticate_dialog.dart';
import 'package:chat_gemini/profile/view/profile_avatar_selection.dart';
import 'package:chat_gemini/profile/view/username_text_field.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileComponent extends StatefulWidget {
  const ProfileComponent({
    required this.toCompleteProfile,
    super.key,
  });

  final bool toCompleteProfile;

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  ProfileCubit get _cubit => context.read<ProfileCubit>();
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: CustomAppBar(context, title: 'Profile'),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (BuildContext context, ProfileState state) {
            if (state is ProfileError) {
              if (state.needToReathenticate) {
                _showReauthenicateDialog(context);
              } else {
                showSnackbarMessage(context, message: state.error);
              }
            } else if (state is ProfileDeleted) {
              context.router.replace(const AuthScreenRoute());
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileLoading;

            final username = state.profile?.name ?? '';
            final isUsernameEmpty = username.isEmpty;

            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
              children: [
                Column(
                  children: [
                    ProfileAvatarSelection(
                      isLoading: isLoading,
                      avatar: state.profile?.photoUrl,
                      onAttachFilePressed: _cubit.updateProfilePhoto,
                    ),
                    const Gap(20),
                    Center(
                      child: Text(
                        state.profile?.email ?? 'No email',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const Gap(20),
                    UsernameTextField(
                      formKey: _formKey,
                      isLoading: isLoading,
                      hint: isUsernameEmpty ? 'Enter username' : username,
                      onEdit: (String text) => _onSaveUserName(text, _cubit),
                      controller: _controller,
                    ),
                    const Gap(84),
                    PrivacyPolicyTextButton(
                      onPressed: () => context.router.push(const Terms()),
                      title: 'Terms of Use',
                    ),
                    const Gap(8),
                    PrivacyPolicyTextButton(
                      onPressed: () => context.router.push(const Privacy()),
                      title: 'Privacy Policy',
                    ),
                    const Gap(20),
                    if (widget.toCompleteProfile)
                      _ElevatedButton(
                        title: 'Continue',
                        onPressed: () => _completeAccountContinue(username),
                      )
                    else
                      _UserControlButtons(
                        isLoading: isLoading,
                        onLogout: () => logout(
                          context,
                          context.read<AuthCubit>(),
                        ),
                        onDelete: _onDeletePressed,
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _completeAccountContinue(String username) {
    final enteredUsername = _controller.text.trim();
    if (enteredUsername.isNotEmpty) {
      if (username == enteredUsername) {
        context.router.replace(ChatScreenRoute());
      } else {
        _onSaveUserName(enteredUsername, _cubit);
      }
    }
  }

  void _onDeletePressed() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return ConfirmationAlertDialog(
          title: 'Are you sure you would like to delete the account?',
          onPressed: () {
            Navigator.of(context).pop();
            _cubit.deleteAccount();
          },
        );
      },
    );
  }

  Future<void> _showReauthenicateDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: _cubit,
          child: ReauthenticateDialog(
            onGoogleReauthenticate: () => _cubit.reauthenticateAndDeleteUser(
              isGoogleSignIn: true,
            ),
            onEmailReauthenticate: ({
              required String email,
              required String password,
            }) =>
                _cubit.reauthenticateAndDeleteUser(
              email: email,
              password: password,
            ),
          ),
        );
      },
    );
  }

  void _onSaveUserName(String text, ProfileCubit cubit) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      cubit.updateUsername(text);
    }
  }
}

class PrivacyPolicyTextButton extends StatelessWidget {
  const PrivacyPolicyTextButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _UserControlButtons extends StatelessWidget {
  const _UserControlButtons({
    required this.onLogout,
    required this.onDelete,
    this.isLoading = false,
  });

  final bool isLoading;
  final VoidCallback onLogout;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ElevatedButton(
          onPressed: isLoading ? null : onLogout,
          bgColor: Colors.transparent,
          textColor: Theme.of(context).colorScheme.secondary,
          borderColor: Theme.of(context).colorScheme.secondary,
          title: 'Logout',
        ),
        const Gap(10),
        _ElevatedButton(
          onPressed: isLoading ? null : onDelete,
          bgColor: const Color.fromARGB(255, 255, 142, 142),
          textColor: Theme.of(context).colorScheme.secondary,
          borderColor: const Color.fromARGB(255, 255, 112, 112),
          title: 'Delete profile',
        ),
      ],
    );
  }
}

class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({
    required this.title,
    required this.onPressed,
    this.bgColor,
    this.textColor,
    this.borderColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
          backgroundColor: WidgetStateProperty.all(bgColor),
          foregroundColor: WidgetStateProperty.all(textColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius16,
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(color: borderColor!),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
