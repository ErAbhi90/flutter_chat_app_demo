import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthState {
  notAuthenticated,
  isAuthenticating,
  authenticated,
}

class AuthManager with ChangeNotifier {
  AuthState _authState = AuthState.notAuthenticated;

  StreamSubscription<User?>? _userStreamSubscription;

  final StreamController<AuthState> _userAuthenticatingStreamController = StreamController<AuthState>.broadcast();
  Stream<AuthState> get userAuthenticatingStream => _userAuthenticatingStreamController.stream;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  bool get isUserAuthenticating => _authState == AuthState.isAuthenticating;
  bool get isUserAuthenticated => _authState == AuthState.authenticated;

  User? _firebaseAuthUser;
  final _fbAuth = FirebaseAuth.instance;

  String get displayName => _firebaseAuthUser?.displayName ?? '';
  String get userID => _firebaseAuthUser?.uid ?? '';
  String get emailAddress => _firebaseAuthUser?.email ?? '';
  String get photoUrl => _firebaseAuthUser?.photoURL ?? '';

  AuthManager() {
    _monitorAuthenticationState();
  }

  void _monitorAuthenticationState() {
    _userStreamSubscription = _fbAuth.authStateChanges().listen((User? userUpdate) {
      if (kDebugMode) {
        print(userUpdate == null ? 'User logged-out.' : 'Auth state change. User info:\n$userUpdate');
      }
      _firebaseAuthUser = userUpdate;
      _setAuthState(userUpdate == null ? AuthState.notAuthenticated : AuthState.authenticated);
    });
    _monitorForRedirectCallbackStatus();
  }

  void _monitorForRedirectCallbackStatus() async {
    try {
      _setAuthState(AuthState.isAuthenticating);
      final userCred = await _fbAuth.getRedirectResult();
      _setAuthState(userCred.user == null ? AuthState.notAuthenticated : AuthState.authenticated);
    } catch (e) {
      _setAuthState(AuthState.notAuthenticated);
    }
  }

  void _setAuthState(AuthState authState) {
    _authState = authState;
    loggedIn = _authState == AuthState.authenticated;
    _userAuthenticatingStreamController.add(authState);
  }

  @override
  void dispose() {
    _userStreamSubscription?.cancel();
    super.dispose();
  }
}
