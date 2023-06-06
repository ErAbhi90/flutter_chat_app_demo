import 'package:flutter_chat_app_demo/app_settings/settings.dart';

class NewMessageViewModel with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  final _firebaseManager = GetIt.I<FirebaseManager>();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void subitMessage(BuildContext context) async {
    final message = messageController.text;
    if (message.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    //Clear text
    messageController.clear();
    //Send to firebase
    await _firebaseManager.addMessage(message);
  }
}
