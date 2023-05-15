import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_config.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_strings.dart';
import 'package:flutter_chat_app_demo/app_settings/router/app_router.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await AppConfig.configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = GetIt.I<AppRouter>().router;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
