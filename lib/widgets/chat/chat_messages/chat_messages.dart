import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/widgets/chat/chat_bubble/message_bubble.dart';
import 'package:flutter_chat_app_demo/widgets/chat/chat_messages/chat_messages_view_model.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatMessagesViewModel>(
      create: (_) => ChatMessagesViewModel(),
      child: Consumer<ChatMessagesViewModel>(
        builder: (context, vm, _) => StreamBuilder(
          stream: vm.getChatMessageStream(),
          builder: (context, chatSnapshots) {
            if (chatSnapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
              return const Center(
                child: Text('No messages found.'),
              );
            }

            if (chatSnapshots.hasError) {
              return const Center(
                child: Text('Something went wrong.'),
              );
            }

            final loadedMessages = chatSnapshots.data!.docs;
            return ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 40.0,
                  left: 13,
                  right: 13,
                ),
                reverse: true,
                itemCount: loadedMessages.length,
                itemBuilder: (ctx, index) {
                  final chatMessage = loadedMessages[index].data();
                  final nextChatMessage = index + 1 < loadedMessages.length ? loadedMessages[index + 1].data() : null;
                  final currentMessageUserId = chatMessage['userId'];
                  final nextMessageUserId = nextChatMessage != null ? nextChatMessage['userId'] : null;
                  final nextUserIsSame = nextMessageUserId == currentMessageUserId;
                  if (nextUserIsSame) {
                    return MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: vm.matchUserId(currentMessageUserId),
                    );
                  } else {
                    return MessageBubble.first(
                      userImage: chatMessage['userImage'],
                      username: chatMessage['username'],
                      message: chatMessage['text'],
                      isMe: vm.matchUserId(currentMessageUserId),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}
