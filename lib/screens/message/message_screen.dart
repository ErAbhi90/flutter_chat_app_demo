import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/screens/message/message_screen_view_model.dart';
import 'package:flutter_chat_app_demo/widgets/chat/chat_messages/chat_messages.dart';
import 'package:flutter_chat_app_demo/widgets/chat/new_message/new_message.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageScreenViewModel>(
      create: (_) => MessageScreenViewModel(),
      child: Consumer<MessageScreenViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => vm.onProfileImageTap(context),
                      child: CircleAvatar(
                        backgroundColor: AppColors.dividerColor,
                        maxRadius: 40,
                        child: vm.displayImage(),
                      ),
                    ),
                    Positioned(
                        bottom: 5.0,
                        right: 0,
                        height: 14.0,
                        child: Container(
                          width: 14.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2.0,
                                color: AppColors.primaryText,
                              ),
                              color: AppColors.green,
                              borderRadius: const BorderRadius.all(Radius.circular(
                                12.0,
                              ))),
                        ))
                  ],
                ),
              ),
              title: const Text("Messages"),
            ),
            body: const Column(
              children: [
                Expanded(
                  child: ChatMessages(),
                ),
                NewMessage(),
              ],
            ),
          );
        },
      ),
    );
  }
}
