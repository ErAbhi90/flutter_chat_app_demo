import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/utils/field_validators.dart';

class AuthScreenViewModel with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool isAuthenticating = false;
  String? emailAddress;
  String? password;
  String? username;
  File? selectedImage;

  final _authManager = GetIt.I<AuthManager>();
  final _logManager = GetIt.I<LogManager>();
  final _firebaseManager = GetIt.I<FirebaseManager>();

  void setEmail(String? email) => emailAddress = email;

  void setUsername(String? user) => username = user;

  String? validateEmail(String? value) => emailValidationMessage(value);

  String? validateUsername(String? value) => usernameValidationMessage(value);

  void setPassword(String? pass) => password = pass;

  void setImage(File? image) => selectedImage = image;

  String? validatePassword(String? value) => passwordValidationMessage(value);

  void textBtnPressed() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void onSubmit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid && !isLogin && selectedImage == null) {
      return;
    }
    formKey.currentState!.save();

    try {
      isAuthenticating = true;
      notifyListeners();
      if (isLogin) {
        await _authManager.onSignInWithEmailAndPassword(context, emailAddress!, password!);
      } else {
        await _authManager.onSignUpWithEmailAndPassword(context, emailAddress!, password!);
        await _firebaseManager.storeImageToStorage(selectedImage, username);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        _logManager.logError('Firebase Exception Login--> $e');
      }
      if (e.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed'),
        ),
      );
      isAuthenticating = false;
      notifyListeners();
    }
  }

  Future<void> onGoogleSignInPressed(BuildContext context) async {
    final navigator = GoRouter.of(context);
    try {
      await _authManager.handleSignInWithGoogle();
      final userCredentials = _authManager.userCredentials;
      if (userCredentials != null) {
        DocumentSnapshot userExist = await _firebaseManager.checkUserExist(userCredentials);
        if (userExist.exists) {
          _logManager.logInfo('User Already Exists in Database');
        } else {
          await _firebaseManager.storeUserDataToFirestore();
        }
        navigator.pushReplacementNamed(AppRoutes.message.getName);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        _logManager.logError('Firebase Exception Login--> $e');
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed'),
        ),
      );
    } on PlatformException catch (e) {
      if (kDebugMode) {
        _logManager.logError('Platform Exception Login--> $e');
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed'),
        ),
      );
    }
  }
}
