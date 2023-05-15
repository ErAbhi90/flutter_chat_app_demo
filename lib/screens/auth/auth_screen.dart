import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_colors.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_images.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_strings.dart';
import 'package:flutter_chat_app_demo/screens/auth/auth_screen_view_model.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: AppColors.backgroundColor,
    );

    final appLogo = Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(AppImages.logo),
        ),
      ),
    );

    const appTitleText = Text(
      AppStrings.appTitle,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
    );

    final googleIcon = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Image.network(
        AppImages.googleIcon,
        width: 30,
        height: 50,
      ),
    );

    return ChangeNotifierProvider<AuthScreenViewModel>(
      create: (_) => AuthScreenViewModel(),
      child: Consumer<AuthScreenViewModel>(
        builder: (context, vm, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                appLogo,
                appTitleText,
                const SizedBox(height: 30),
                ElevatedButton(
                  style: style,
                  onPressed: vm.onGoogleSignInPressed,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      googleIcon,
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(AppStrings.googleSignIn),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
