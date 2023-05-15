import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/managers/firebase_manager.dart';
import 'package:get_it/get_it.dart';

class AuthScreenViewModel with ChangeNotifier {
  void onGoogleSignInPressed() async {
    final firebaseManager = GetIt.I<FirebaseManager>();
    await firebaseManager.signInWithGoogle();
  }
}
