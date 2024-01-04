import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/chat_model.dart';
import 'package:social_flow/provider/chat_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    late BoxDecoration boxDecoration;
    late AlignmentGeometry align;
    late EdgeInsetsGeometry padding;
    late CrossAxisAlignment columnCrossAxisAlignment;
    if (chat.sendBy == auth.currentUser!.uid) {
      boxDecoration = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
            : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(14),
        ),
      );
      align = Alignment.centerRight;
      padding = const EdgeInsets.only(left: 32);
      columnCrossAxisAlignment = CrossAxisAlignment.start;
    } else {
      boxDecoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColors.firstGradientColor.withOpacity(0.7),
            CustomColors.secondGradientColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(0),
        ),
      );
      align = Alignment.centerLeft;
      padding = const EdgeInsets.only(right: 32);
      columnCrossAxisAlignment = CrossAxisAlignment.end;
    }
    return Consumer<ChatNotifier>(builder: (context, notifier, _) {
      return Padding(
        padding: padding,
        child: InkWell(
          onLongPress: () async {
            if (chat.sendBy == auth.currentUser!.uid) {
              await notifier.deleteMessage(context: context, chatRoomId: chat.chatRoomId, chatId: chat.chatId);
            }
          },
          child: Container(
            alignment: align,
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: columnCrossAxisAlignment,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: boxDecoration,
                  child: Text(
                    chat.message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      chat.sendBy == auth.currentUser!.uid ? const EdgeInsets.only(left: 2) : const EdgeInsets.only(right: 2),
                  child: Text(
                    chat.formatedTime,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
