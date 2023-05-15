enum AppRoutes {
  auth,
  home,
}

extension AppRoutesExt on AppRoutes {
  String get getPath {
    switch (this) {
      case AppRoutes.home:
        return '/';
      case AppRoutes.auth:
        return '/auth';
      default:
        return '/';
    }
  }

  String get getName {
    switch (this) {
      case AppRoutes.auth:
        return 'authScreen';
      case AppRoutes.home:
        return 'home';
      default:
        return 'home';
    }
  }
}
