// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../app/theme/theme_cubit.dart' as _i9;
import '../auth/cubit/auth_cubit.dart' as _i17;
import '../auth/data/auth_service.dart' as _i12;
import '../auth/data/repository/user_repository.dart' as _i11;
import '../chat/cubit/chat_cubit.dart' as _i18;
import '../chat/data/ai_chat_service.dart' as _i3;
import '../chat/data/repository/chat_repository.dart' as _i13;
import '../chat/data/repository/media_storage_repository.dart' as _i8;
import '../chats/cubit/chats_cubit.dart' as _i14;
import '../profile/cubit/profile_cubit.dart' as _i15;
import '../profile/data/repository/user_media_storage_repository.dart' as _i10;
import '../splash/cubit/splash_cubit.dart' as _i16;
import 'firebase_services_module.dart' as _i19;

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
    gh.singleton<_i3.AiChatService>(_i3.AiChatService());
    gh.singleton<_i4.FirebaseAuth>(authModule.firebaseAuth);
    gh.singleton<_i5.FirebaseFirestore>(authModule.firestoreInstance);
    gh.singleton<_i6.FirebaseStorage>(authModule.storage);
    gh.singleton<_i7.GoogleSignIn>(authModule.googleSignIn);
    gh.singleton<_i8.MediaStorageRepository>(
        _i8.MediaStorageRepository(gh<_i6.FirebaseStorage>()));
    gh.factory<_i9.ThemeCubit>(() => _i9.ThemeCubit());
    gh.singleton<_i10.UserMediaStorageRepository>(
        _i10.UserMediaStorageRepository(gh<_i6.FirebaseStorage>()));
    gh.singleton<_i11.UserRepository>(
        _i11.UserRepository(firestoreInstance: gh<_i5.FirebaseFirestore>()));
    gh.singleton<_i12.AuthService>(_i12.AuthService(
      gh<_i4.FirebaseAuth>(),
      gh<_i7.GoogleSignIn>(),
    ));
    gh.singleton<_i13.ChatRepository>(
        _i13.ChatRepository(firestoreInstance: gh<_i5.FirebaseFirestore>()));
    gh.factory<_i14.ChatsCubit>(() => _i14.ChatsCubit(
          gh<_i13.ChatRepository>(),
          gh<_i12.AuthService>(),
        ));
    gh.factory<_i15.ProfileCubit>(() => _i15.ProfileCubit(
          gh<_i12.AuthService>(),
          gh<_i11.UserRepository>(),
          gh<_i10.UserMediaStorageRepository>(),
          gh<_i13.ChatRepository>(),
          gh<_i8.MediaStorageRepository>(),
        ));
    gh.factory<_i16.SplashCubit>(() => _i16.SplashCubit(
          gh<_i12.AuthService>(),
          gh<_i11.UserRepository>(),
        ));
    gh.factory<_i17.AuthCubit>(() => _i17.AuthCubit(
          gh<_i12.AuthService>(),
          gh<_i11.UserRepository>(),
        ));
    gh.factory<_i18.ChatCubit>(() => _i18.ChatCubit(
          gh<_i13.ChatRepository>(),
          gh<_i12.AuthService>(),
          gh<_i11.UserRepository>(),
          gh<_i8.MediaStorageRepository>(),
          gh<_i3.AiChatService>(),
        ));
    return this;
  }
}

class _$AuthModule extends _i19.AuthModule {}
