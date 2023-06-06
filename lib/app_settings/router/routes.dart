enum AppRoutes {
  auth,
  splash,
  message,
  profile,
  search,
}

extension AppRoutesExt on AppRoutes {
  String get getPath {
    switch (this) {
      case AppRoutes.message:
        return '/';
      case AppRoutes.auth:
        return '/auth';
      case AppRoutes.splash:
        return '/splash';
      case AppRoutes.profile:
        return '/profile';
      case AppRoutes.search:
        return '/search';
      default:
        return '/';
    }
  }

  String get getName {
    switch (this) {
      case AppRoutes.auth:
        return 'authScreen';
      case AppRoutes.splash:
        return 'splashScreen';
      case AppRoutes.message:
        return 'messageScreen';
      case AppRoutes.profile:
        return 'profileScreen';
      case AppRoutes.search:
        return 'searchScreen';
      default:
        return 'messageScreen';
    }
  }
}
