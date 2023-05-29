import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/text.dart';

class CommentCartWidget extends StatelessWidget {
  const CommentCartWidget({super.key, required this.snap});
  final Map snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(snap['profilePic']),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snap['name'],
                    style: TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
                  ),
                  Text(snap['text']),
                ],
              ),
            ),
          ),
          CustomTextWidget(
            name: DateFormat.yMMMd().format(snap['datePublished'].toDate()),
            size: 10,
            fontWeight: FontWeight.w400,
            textColor: kWhiteColor.withOpacity(0.7),
          )
        ],
      ),
    );
  }
}
