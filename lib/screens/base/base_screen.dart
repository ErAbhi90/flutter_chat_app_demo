import 'package:flutter/material.dart';
import 'package:flutter_chat_app_demo/screens/base/base_screen_view_model.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.screen});

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseScreenViewModel>(
      create: (_) => BaseScreenViewModel(),
      child: Consumer<BaseScreenViewModel>(
        builder: (context, vm, _) => Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This is the main content.
              Expanded(child: screen),
            ],
          ),
        ),
      ),
    );
  }
}
