import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/managers/data_manager.dart';

class AppConfig {
  static Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Only if the device is Android then remove the status bar color
    if (!kIsWeb && Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }

    // Init the APP

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Init Firebase related services
    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Init DI
    GetIt.I.registerSingleton<FirebaseApp>(firebaseApp);
    GetIt.I.registerSingleton<LogManager>(LogManager());
    GetIt.I.registerSingleton<AuthManager>(AuthManager());
    GetIt.I.registerSingleton<FirebaseManager>(FirebaseManager());
    GetIt.I.registerSingleton<AppRouter>(AppRouter());
    GetIt.I.registerSingleton<DataManager>(DataManager());
  }
}
