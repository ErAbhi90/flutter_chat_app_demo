import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app_demo/app_settings/router/app_router.dart';
import 'package:flutter_chat_app_demo/managers/auth_manager.dart';
import 'package:flutter_chat_app_demo/managers/firebase_manager.dart';
import 'package:flutter_chat_app_demo/managers/log_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/default_firebase_options.dart';

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
    GetIt.I.registerSingleton<FirebaseManager>(FirebaseManager());
    GetIt.I.registerSingleton<AuthManager>(AuthManager());
    GetIt.I.registerSingleton<AppRouter>(AppRouter());
    /*  GetIt.I.registerSingleton<DataManager>(DataManager());
    GetIt.I.registerSingleton<FirebaseManager>(FirebaseManager());
    GetIt.I.registerSingleton<FirebaseStorageManager>(FirebaseStorageManager()); */
  }
}
