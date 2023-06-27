import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/models/message_model.dart';
import 'package:social_flow/presentation/widgets/message_widgets/message_card_widget.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DateDividerWidget extends StatelessWidget {
  const DateDividerWidget({super.key, required this.state});
  final MessageModelTwo state;

  @override
  Widget build(BuildContext context) {
    return StickyHeaderBuilder(
      builder: (context, stuckAmount) {
        String dateOfChat;
        DateTime convertedDate = state.createdOn!;
        if (convertedDate.day == DateTime.now().day &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Today ${DateFormat.jm().format(state.createdOn!)}";
        } else if (convertedDate.day == DateTime.now().day - 1 &&
            convertedDate.month == DateTime.now().month &&
            convertedDate.year == DateTime.now().year) {
          dateOfChat = "Yesterday ${DateFormat.jm().format(state.createdOn!)}";
        } else {
          dateOfChat = "${convertedDate.day} ${DateFormat.MMM().format(convertedDate)} ${convertedDate.year}";
        }

        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              dateOfChat,
            ),
          ),
        );
      },
      content: MessageCardWidget(messageDetails: state),
    );
  }
}
