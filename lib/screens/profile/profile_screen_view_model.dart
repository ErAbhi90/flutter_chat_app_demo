import 'package:flutter_chat_app_demo/app_settings/settings.dart';

class ProfileScreenViewModel with ChangeNotifier {
  final _authManager = GetIt.I<AuthManager>();

  String? get getImage => _authManager.photoUrl;

  Widget displayImage() {
    return getImage != null
        ? ClipOval(
            child: Image.network(getImage!),
          )
        : const Icon(Icons.person);
  }

  void _onSignOutPressed() async {
    await _authManager.handleSignInOut();
  }

  Future<void> showAlertDialog(BuildContext context) async {
    final navigator = GoRouter.of(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                navigator.pop();
              },
            ),
            TextButton(
              onPressed: _onSignOutPressed,
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
