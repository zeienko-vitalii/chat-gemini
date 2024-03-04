import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  final _authService = AuthService();
  final _userRepository = UserRepository();

  Future<void> checkUser() async {
    try {
      emit(SplashLoading());
      final currentUser = _authService.currentUser;
      if (currentUser == null) {
        emit(SplashLoggedOut());
      } else {
        final user = await _userRepository.getUser(currentUser.uid);

        if (user.name.isEmpty) {
          emit(SplashProfileIncomplete());
        } else {
          emit(SplashSuccessful());
        }
      }
    } catch (e) {
      emit(SplashLoggedOut());
    }
  }
}
