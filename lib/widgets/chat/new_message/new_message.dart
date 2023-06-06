import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/widgets/chat/new_message/new_message_view_model.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewMessageViewModel>(
      create: (_) => NewMessageViewModel(),
      child: Consumer<NewMessageViewModel>(
        builder: (context, vm, _) => Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 1.0,
            bottom: 14.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: vm.messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: const InputDecoration(labelText: 'Send a message'),
                ),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => vm.subitMessage(context),
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
