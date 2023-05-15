// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5r2-jrIahIKpESsodwZWTj-3p6aWdeqo',
    appId: '1:1025103682621:web:e351927e179a9899225e54',
    messagingSenderId: '1025103682621',
    projectId: 'flutter-chat-app-demo-50b7e',
    authDomain: 'flutter-chat-app-demo-50b7e.firebaseapp.com',
    storageBucket: 'flutter-chat-app-demo-50b7e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC20hAJKDVywBgOCyL6t-wLarAmQwtc8Cg',
    appId: '1:1025103682621:android:f4793dfe15ba83f8225e54',
    messagingSenderId: '1025103682621',
    projectId: 'flutter-chat-app-demo-50b7e',
    storageBucket: 'flutter-chat-app-demo-50b7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQJP-wH_5M5h5w3m9DQoHbj76EnjpEh18',
    appId: '1:1025103682621:ios:afd4f5f537fcad2f225e54',
    messagingSenderId: '1025103682621',
    projectId: 'flutter-chat-app-demo-50b7e',
    storageBucket: 'flutter-chat-app-demo-50b7e.appspot.com',
    iosClientId: '1025103682621-3g057g8siit2u03v8fka784ulvug760l.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChatAppDemo',
  );
}
