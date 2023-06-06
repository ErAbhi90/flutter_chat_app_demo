import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app_demo/app_settings/settings.dart';

class ChatMessagesViewModel with ChangeNotifier {
  final _firebaseManager = GetIt.I<FirebaseManager>();
  final _autheManager = GetIt.I<AuthManager>();

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessageStream() => _firebaseManager.getChatMessages();

  bool matchUserId(String userId) {
    return _autheManager.userID == userId;
  }
}
