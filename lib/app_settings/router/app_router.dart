import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/app_settings/router/routes.dart';
import 'package:flutter_chat_app_demo/screens/auth/auth_screen.dart';
import 'package:flutter_chat_app_demo/screens/base/base_screen.dart';
import 'package:flutter_chat_app_demo/screens/error/error_page.dart';
import 'package:flutter_chat_app_demo/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(
    debugLogDiagnostics: true,
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
        name: AppRoutes.home.getName,
        path: AppRoutes.home.getPath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const BaseScreen(
              screen: HomeScreen(),
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      // if the user is not logged in, they need to login
      final loginLocation = state.namedLocation(AppRoutes.auth.getName);
      final rootLocation = state.namedLocation(AppRoutes.home.getName);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        return rootLocation;
      } else {
        return loginLocation;
      }
    },
  );

  static goToRoot(BuildContext context) {
    Router.neglect(context, () => context.pushNamed(AppRoutes.home.getName));
  }
}
