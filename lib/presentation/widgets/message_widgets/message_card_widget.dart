import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/message_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({super.key, required this.messageDetails});

  final MessageModelTwo messageDetails;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    BoxDecoration boxDecoration;
    EdgeInsetsGeometry padding;

    if (messageDetails.sendBy == auth.currentUser!.uid) {
      padding = const EdgeInsets.only(left: 12, right: 22, bottom: 6);
      boxDecoration = BoxDecoration(
        color: kMainColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(2),
          topLeft: Radius.circular(12),
        ),
      );
    } else {
      padding = const EdgeInsets.only(left: 22, right: 12, bottom: 6);
      boxDecoration = BoxDecoration(
        color: kWhiteColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(2),
        ),
      );
    }

    return Align(
      alignment: messageDetails.sendBy == auth.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: padding,
        child: InkWell(
          onLongPress: () async {
            if (messageDetails.sendBy == auth.currentUser!.uid) {
              await deleteMessage(
                context: context,
                chatRoom: messageDetails.chatRoomId!,
                messageId: messageDetails.chatId!,
              );
            }
          },
          child: Container(
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: CustomTextWidget(
                name: messageDetails.message ?? '',
                size: 16,
                fontWeight: FontWeight.w500,
                textColor: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
