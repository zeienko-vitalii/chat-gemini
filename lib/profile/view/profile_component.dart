import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/views/logout/logout_dialog.dart';
import 'package:chat_gemini/profile/cubit/profile_cubit.dart';
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(context, title: 'Profile'),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (BuildContext context, ProfileState state) {
            if (state is ProfileError) {
              showSnackbarMessage(context, message: state.error);
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileLoading;

            final username = state.profile?.name ?? '';
            final isUsernameEmpty = username.isEmpty;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileAvatarSelection(
                          isLoading: isLoading,
                          avatar: state.profile?.photoUrl,
                          onAttachFilePressed: (String fileUrl) {
                            _cubit.updateProfilePhoto(fileUrl);
                          },
                        ),
                        const Gap(20),
                        UsernameTextField(
                          formKey: _formKey,
                          isLoading: isLoading,
                          hint: isUsernameEmpty ? 'Enter username' : username,
                          onEdit: (String text) =>
                              _onSaveUserName(text, _cubit),
                          controller: _controller,
                        ),
                      ],
                    ),
                  ),
                  if (widget.toCompleteProfile)
                    _ElevatedButton(
                      onPressed: () {
                        final enteredUsername = _controller.text.trim();
                        if (enteredUsername.isNotEmpty) {
                          if (username == enteredUsername) {
                            context.router.replace(ChatScreenRoute());
                          } else {
                            _onSaveUserName(enteredUsername, _cubit);
                          }
                        }
                      },
                      title: 'Continue',
                    )
                  else
                    _UserControlButtons(
                      isLoading: isLoading,
                      onLogout: () => logout(
                        context,
                        context.read<AuthCubit>(),
                      ),
                      onDelete: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return ConfirmationAlertDialog(
                              title:
                                  // ignore: lines_longer_than_80_chars
                                  'Are you sure you would like to delete the account?',
                              onPressed: () {
                                _cubit.deleteAccount();
                                context.router.replace(const AuthScreenRoute());
                              },
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSaveUserName(String text, ProfileCubit cubit) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      cubit.updateUsername(text);
    }
  }
}

class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({
    required this.title,
    required this.onPressed,
    this.color,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Text(title),
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
          title: 'Logout',
        ),
        const Gap(10),
        _ElevatedButton(
          onPressed: isLoading ? null : onDelete,
          color: Colors.redAccent,
          title: 'Delete profile',
        ),
      ],
    );
  }
}
