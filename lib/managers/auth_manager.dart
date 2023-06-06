import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthState {
  notAuthenticated,
  isAuthenticating,
  authenticated,
}

enum AuthType { email, google }

class AuthManager with ChangeNotifier {
  final logManager = GetIt.I<LogManager>();

  AuthState _authState = AuthState.notAuthenticated;

  AuthType _authType = AuthType.email;

  StreamSubscription<User?>? _userStreamSubscription;

  final StreamController<AuthState> _userAuthenticatingStreamController = StreamController<AuthState>.broadcast();
  Stream<AuthState> get userAuthenticatingStream => _userAuthenticatingStreamController.stream;

  final _fbAuthInstance = FirebaseAuth.instance;

  User? _firebaseAuthUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  UserCredential? _userCredentials;

  UserCredential? get userCredentials => _userCredentials;

  bool get isUserAuthenticating => _authState == AuthState.isAuthenticating;
  bool get isUserAuthenticated => _authState == AuthState.authenticated;
  String get displayName => _firebaseAuthUser?.displayName ?? '';
  String get userID => _firebaseAuthUser?.uid ?? '';
  String get emailAddress => _firebaseAuthUser?.email ?? '';
  String? get photoUrl => _firebaseAuthUser?.photoURL;

  bool get isAuthTypeGoogle => _authType == AuthType.google;

  AuthManager() {
    _setAuthState(AuthState.notAuthenticated);
    _monitorAuthenticationState();
  }

  Future<void> handleSignInWithGoogle() async {
    _authType = AuthType.google;
    _setAuthState(AuthState.isAuthenticating);

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    _userCredentials = await _fbAuthInstance.signInWithCredential(credential);
    if (_userCredentials != null) {
      _setAuthState(AuthState.authenticated);
      return;
    }

    _setAuthState(AuthState.notAuthenticated);
    return;
  }

  Future<void> onSignUpWithEmailAndPassword(BuildContext context, String email, String password) async {
    _authType = AuthType.email;
    _setAuthState(AuthState.isAuthenticating);
    _userCredentials = await _fbAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
    if (_userCredentials != null) {
      _setAuthState(AuthState.authenticated);
      return;
    }
    _setAuthState(AuthState.notAuthenticated);
  }

  Future<void> onSignInWithEmailAndPassword(BuildContext context, String email, String password) async {
    _authType = AuthType.email;
    _setAuthState(AuthState.isAuthenticating);
    _userCredentials = await _fbAuthInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (_userCredentials != null) {
      _setAuthState(AuthState.authenticated);
      return;
    }
    _setAuthState(AuthState.notAuthenticated);
  }

  void _monitorAuthenticationState() {
    _userStreamSubscription = _fbAuthInstance.authStateChanges().listen((User? userUpdate) {
      if (kDebugMode) {
        logManager.logInfo(userUpdate == null ? 'User logged-out.' : 'Auth state change. User info:\n$userUpdate');
      }
      _firebaseAuthUser = userUpdate;
      _setAuthState(userUpdate == null ? AuthState.notAuthenticated : AuthState.authenticated);
    });
    _monitorForRedirectCallbackStatus();
  }

  void _monitorForRedirectCallbackStatus() async {
    try {
      _setAuthState(AuthState.isAuthenticating);
      final userCred = await _fbAuthInstance.getRedirectResult();
      _setAuthState(userCred.user == null ? AuthState.notAuthenticated : AuthState.authenticated);
    } catch (e) {
      _setAuthState(AuthState.notAuthenticated);
    }
  }

  void _setAuthState(AuthState authState) {
    _authState = authState;
    _userAuthenticatingStreamController.add(authState);
    notifyListeners();
  }

  Future<void> handleSignInOut() async {
    if (isAuthTypeGoogle) {
      await _googleSignIn.disconnect();
    }
    await _fbAuthInstance.signOut();
  }

  @override
  void dispose() {
    _userStreamSubscription?.cancel();
    super.dispose();
  }
}
