import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/di/di.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (getIt<AuthService>().isAuthenticated) {
      resolver.next();
    } else {
      resolver
        ..next(false)
        ..redirect(const AuthScreenRoute());
    }
  }
}
