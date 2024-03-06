import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/di/di.dart';
import 'package:chat_gemini/profile/cubit/profile_cubit.dart';
import 'package:chat_gemini/profile/view/profile_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    @PathParam('complete-profile') this.toCompleteProfile = false,
  });

  final bool toCompleteProfile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: ProfileComponent(
        toCompleteProfile: toCompleteProfile,
      ),
    );
  }
}
