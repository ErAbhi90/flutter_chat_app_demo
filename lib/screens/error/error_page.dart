// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_colors.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_images.dart';
import 'package:flutter_chat_app_demo/app_settings/configs/app_strings.dart';
import 'package:flutter_chat_app_demo/app_settings/router/app_router.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: AppColors.backgroundColor,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.chevron_left,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.network(
                AppImages.pageNotFound,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height / 2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                AppStrings.nothingHere,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                AppStrings.pageNotFound,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: style,
                onPressed: () => AppRouter.goToRoot(context),
                child: const Text(AppStrings.backToHomePage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
