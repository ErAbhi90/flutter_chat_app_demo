import 'package:flutter_chat_app_demo/app_settings/settings.dart';

class MessageScreenViewModel with ChangeNotifier {
  final _authManager = GetIt.I<AuthManager>();

  String? get getImage => _authManager.userCredentials?.user?.photoURL;

  Widget displayImage() {
    return Padding(
      padding: const EdgeInsets.all(2), // Border radius
      child: getImage != null
          ? ClipOval(
              child: Image.network(getImage!),
            )
          : const Icon(Icons.person),
    );
  }

  void onProfileImageTap(BuildContext context) {
    final navigator = GoRouter.of(context);
    navigator.pushNamed(AppRoutes.profile.getName);
  }

  void onSearchTap(BuildContext context) {
    final navigator = GoRouter.of(context);
    navigator.pushNamed(AppRoutes.search.getName);
  }
}
