import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (AuthService().isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.next(false);
      resolver.redirect(const AuthScreenRoute());
    }
  }
}
