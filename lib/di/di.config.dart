// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../app/theme/theme_cubit.dart' as _i498;
import '../auth/cubit/auth_cubit.dart' as _i575;
import '../auth/data/auth_service.dart' as _i17;
import '../auth/data/repository/user_repository.dart' as _i603;
import '../chat/cubit/chat_cubit.dart' as _i79;
import '../chat/data/ai_chat/ai_chat_gemini.dart' as _i741;
import '../chat/data/ai_chat/ai_chat_interface.dart' as _i1035;
import '../chat/data/ai_chat/ai_chat_openai.dart' as _i362;
import '../chat/data/repository/chat_repository.dart' as _i401;
import '../chat/data/repository/media_storage_repository.dart' as _i412;
import '../chats/cubit/chats_cubit.dart' as _i125;
import '../profile/cubit/profile_cubit.dart' as _i204;
import '../profile/data/repository/user_media_storage_repository.dart' as _i987;
import '../splash/cubit/splash_cubit.dart' as _i107;
import 'firebase_services_module.dart' as _i617;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authModule = _$AuthModule();
    gh.factory<_i498.ThemeCubit>(() => _i498.ThemeCubit());
    gh.singleton<_i59.FirebaseAuth>(() => authModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(() => authModule.firestoreInstance);
    gh.singleton<_i457.FirebaseStorage>(() => authModule.storage);
    gh.singleton<_i116.GoogleSignIn>(() => authModule.googleSignIn);
    gh.singleton<_i1035.AIChatInterface>(
      () => _i741.AiChatService.new(),
      instanceName: 'AiChatGemini',
    );
    gh.singleton<_i412.MediaStorageRepository>(
        () => _i412.MediaStorageRepository(gh<_i457.FirebaseStorage>()));
    gh.singleton<_i987.UserMediaStorageRepository>(
        () => _i987.UserMediaStorageRepository(gh<_i457.FirebaseStorage>()));
    gh.singleton<_i1035.AIChatInterface>(
      () => _i362.AiChatOpenai.new(),
      instanceName: 'AiChatOpenAi',
    );
    gh.singleton<_i401.ChatRepository>(() =>
        _i401.ChatRepository(firestoreInstance: gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i603.UserRepository>(() =>
        _i603.UserRepository(firestoreInstance: gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i17.AuthService>(() => _i17.AuthService(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
        ));
    gh.factory<_i125.ChatsCubit>(() => _i125.ChatsCubit(
          gh<_i401.ChatRepository>(),
          gh<_i17.AuthService>(),
        ));
    gh.factory<_i204.ProfileCubit>(() => _i204.ProfileCubit(
          gh<_i17.AuthService>(),
          gh<_i603.UserRepository>(),
          gh<_i987.UserMediaStorageRepository>(),
          gh<_i401.ChatRepository>(),
          gh<_i412.MediaStorageRepository>(),
        ));
    gh.factory<_i79.ChatCubit>(() => _i79.ChatCubit(
          gh<_i401.ChatRepository>(),
          gh<_i17.AuthService>(),
          gh<_i603.UserRepository>(),
          gh<_i412.MediaStorageRepository>(),
          gh<_i1035.AIChatInterface>(instanceName: 'AiChatOpenAi'),
          gh<_i1035.AIChatInterface>(instanceName: 'AiChatOpenAi'),
        ));
    gh.factory<_i107.SplashCubit>(() => _i107.SplashCubit(
          gh<_i17.AuthService>(),
          gh<_i603.UserRepository>(),
        ));
    gh.factory<_i575.AuthCubit>(() => _i575.AuthCubit(
          gh<_i17.AuthService>(),
          gh<_i603.UserRepository>(),
        ));
    return this;
  }
}

class _$AuthModule extends _i617.AuthModule {}
