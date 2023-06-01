import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/text.dart';

class CommentLengthWidget extends StatelessWidget {
  const CommentLengthWidget({
    super.key,
    required this.snap,
  });

  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').doc(snap['postId']).collection('comments').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: CustomTextWidget(
              name: "add comments",
              size: 14,
              fontWeight: FontWeight.w200,
              textColor: kWhiteColor.withOpacity(0.7),
            ),
          );
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentScreen(snap: snap),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: snapshot.data!.docs.isEmpty
                ? CustomTextWidget(
                    name: "add comments",
                    size: 14,
                    fontWeight: FontWeight.w200,
                    textColor: kWhiteColor.withOpacity(0.7),
                  )
                : CustomTextWidget(
                    name: "view all ${snapshot.data!.docs.length} comments",
                    size: 14,
                    fontWeight: FontWeight.w200,
                    textColor: kWhiteColor.withOpacity(0.7),
                  ),
          ),
        );
      },
    );
  }
}

