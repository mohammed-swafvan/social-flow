import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class CommentCartWidget extends StatelessWidget {
  const CommentCartWidget({super.key, required this.snap, required this.postId});
  final Map snap;
  final String postId;

  @override
  Widget build(BuildContext context) {
    final ccurrentUseruid = FirebaseAuth.instance.currentUser!.uid;
    return GestureDetector(
      onLongPress: () async {
        if (snap['uid'] == ccurrentUseruid) {
          await deleteDialogue(snap: snap, ctx: context, isPost: false, postId: postId);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        width: double.infinity,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  name: DateFormat.jm().format(snap['datePublished'].toDate()),
                  size: 10,
                  fontWeight: FontWeight.w400,
                  textColor: kWhiteColor.withOpacity(0.7),
                ),
                CustomTextWidget(
                  name: DateFormat.yMMMd().format(snap['datePublished'].toDate()),
                  size: 10,
                  fontWeight: FontWeight.w400,
                  textColor: kWhiteColor.withOpacity(0.7),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
