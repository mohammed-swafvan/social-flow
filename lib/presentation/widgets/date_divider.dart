import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/models/chat_model.dart';
import 'package:social_flow/presentation/widgets/chat_card.dart';
import 'package:social_flow/theme/custom_colors.dart';
import 'package:sticky_headers/sticky_headers.dart';

class DateDivider extends StatelessWidget {
  const DateDivider({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return StickyHeaderBuilder(
      builder: (context, stuckAmount) {
        String dateOfChat;
        DateTime convertedDate = chat.createdOn;
        if (convertedDate.day == DateTime.now().day &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Today";
        } else if (convertedDate.day == DateTime.now().day - 1 &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Yesterday";
        } else {
          dateOfChat = "${convertedDate.day} ${DateFormat.MMM().format(convertedDate)} ${convertedDate.year}";
        }

        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    CustomColors.firstGradientColor.withOpacity(0.2),
                    CustomColors.secondGradientColor.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: Text(
                dateOfChat,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        );
      },
      content: ChatCard(chat: chat),
    );
  }
}
