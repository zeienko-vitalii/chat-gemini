// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:firebase_storage/firebase_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;

import '../app/theme/theme_cubit.dart' as _i11;
import '../auth/cubit/auth_cubit.dart' as _i19;
import '../auth/data/auth_service.dart' as _i14;
import '../auth/data/repository/user_repository.dart' as _i13;
import '../chat/cubit/chat_cubit.dart' as _i20;
import '../chat/data/ai_chat/ai_chat_gemini.dart' as _i5;
import '../chat/data/ai_chat/ai_chat_interface.dart' as _i3;
import '../chat/data/ai_chat/ai_chat_openai.dart' as _i4;
import '../chat/data/repository/chat_repository.dart' as _i15;
import '../chat/data/repository/media_storage_repository.dart' as _i10;
import '../chats/cubit/chats_cubit.dart' as _i16;
import '../profile/cubit/profile_cubit.dart' as _i17;
import '../profile/data/repository/user_media_storage_repository.dart' as _i12;
import '../splash/cubit/splash_cubit.dart' as _i18;
import 'firebase_services_module.dart' as _i21;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authModule = _$AuthModule();
    gh.singleton<_i3.AIChatInterface>(
      _i4.AiChatOpenai(),
      instanceName: 'AiChatOpenAi',
    );
    gh.singleton<_i3.AIChatInterface>(
      _i5.AiChatService(),
      instanceName: 'AiChatGemini',
    );
    gh.singleton<_i6.FirebaseAuth>(authModule.firebaseAuth);
    gh.singleton<_i7.FirebaseFirestore>(authModule.firestoreInstance);
    gh.singleton<_i8.FirebaseStorage>(authModule.storage);
    gh.singleton<_i9.GoogleSignIn>(authModule.googleSignIn);
    gh.singleton<_i10.MediaStorageRepository>(
        _i10.MediaStorageRepository(gh<_i8.FirebaseStorage>()));
    gh.factory<_i11.ThemeCubit>(() => _i11.ThemeCubit());
    gh.singleton<_i12.UserMediaStorageRepository>(
        _i12.UserMediaStorageRepository(gh<_i8.FirebaseStorage>()));
    gh.singleton<_i13.UserRepository>(
        _i13.UserRepository(firestoreInstance: gh<_i7.FirebaseFirestore>()));
    gh.singleton<_i14.AuthService>(_i14.AuthService(
      gh<_i6.FirebaseAuth>(),
      gh<_i9.GoogleSignIn>(),
    ));
    gh.singleton<_i15.ChatRepository>(
        _i15.ChatRepository(firestoreInstance: gh<_i7.FirebaseFirestore>()));
    gh.factory<_i16.ChatsCubit>(() => _i16.ChatsCubit(
          gh<_i15.ChatRepository>(),
          gh<_i14.AuthService>(),
        ));
    gh.factory<_i17.ProfileCubit>(() => _i17.ProfileCubit(
          gh<_i14.AuthService>(),
          gh<_i13.UserRepository>(),
          gh<_i12.UserMediaStorageRepository>(),
          gh<_i15.ChatRepository>(),
          gh<_i10.MediaStorageRepository>(),
        ));
    gh.factory<_i18.SplashCubit>(() => _i18.SplashCubit(
          gh<_i14.AuthService>(),
          gh<_i13.UserRepository>(),
        ));
    gh.factory<_i19.AuthCubit>(() => _i19.AuthCubit(
          gh<_i14.AuthService>(),
          gh<_i13.UserRepository>(),
        ));
    gh.factory<_i20.ChatCubit>(() => _i20.ChatCubit(
          gh<_i15.ChatRepository>(),
          gh<_i14.AuthService>(),
          gh<_i13.UserRepository>(),
          gh<_i10.MediaStorageRepository>(),
          gh<_i3.AIChatInterface>(instanceName: 'AiChatOpenAi'),
          gh<_i3.AIChatInterface>(instanceName: 'AiChatOpenAi'),
        ));
    return this;
  }
}

class _$AuthModule extends _i21.AuthModule {}
