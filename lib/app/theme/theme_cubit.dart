import 'package:bloc/bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeSystem());

  void changeTheme() {
    emit(state is ThemeLight? ? ThemeDark() : ThemeLight());
  }
}
