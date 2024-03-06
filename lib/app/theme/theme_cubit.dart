import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeSystem());

  void changeTheme() {
    emit(state is ThemeLight? ? ThemeDark() : ThemeLight());
  }
}
