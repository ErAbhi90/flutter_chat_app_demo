import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/models/models.dart';
import 'package:flutter_chat_app_demo/screens/screens.dart';
import 'package:flutter_chat_app_demo/screens/splash/splash.dart';

class AppRouter {
  final _authManager = GetIt.I<AuthManager>();
  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _authManager,
    initialLocation: AppRoutes.message.getName,
    routes: [
      GoRoute(
        name: AppRoutes.auth.getName,
        path: AppRoutes.auth.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const BaseScreen(
              screen: AuthScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.splash.getName,
        path: AppRoutes.splash.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const BaseScreen(
              screen: SplashScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.message.getName,
        path: AppRoutes.message.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const MessageScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.profile.getName,
        path: AppRoutes.profile.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const BaseScreen(
              screen: ProfileScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.search.getName,
        path: AppRoutes.search.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: BaseScreen(
              screen: SearchScreen(
                user: User(),
              ),
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    redirect: (context, state) {
      // if the user is not logged in, they need to login
      final loginLocation = state.namedLocation(AppRoutes.auth.getName);
      final loggingIn = state.matchedLocation == loginLocation;
      final rootLocation = state.namedLocation(AppRoutes.message.getName);
      final splashLocation = state.namedLocation(AppRoutes.splash.getName);
      final isAuthenticated = _authManager.isUserAuthenticated;
      final isAuthenticating = _authManager.isUserAuthenticating;

      if (isAuthenticating && !loggingIn) return splashLocation;
      // if the user is not authenticated and is not on the login page, send them to the login page
      if (!isAuthenticated && !loggingIn) return loginLocation;

      // if the user is authenticated but still on the login page, send them to the home page
      if (isAuthenticated && loggingIn) return rootLocation;

      // no need to redirect at all
      return null;
    },
  );

  static goToRoot(BuildContext context) {
    Router.neglect(context, () => context.pushNamed(AppRoutes.message.getName));
  }
}
