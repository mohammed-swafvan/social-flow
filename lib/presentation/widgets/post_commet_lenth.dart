import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/provider/post_card_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class PostCommentLength extends StatefulWidget {
  const PostCommentLength({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<PostCommentLength> createState() => _PostCommentLengthState();
}

class _PostCommentLengthState extends State<PostCommentLength> {
  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostCardNotifier>(builder: (context, notifier, _) {
      return StreamBuilder(
          stream: notifier.postCommentStream,
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || notifier.postCommentStream == null) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Theme.of(context).brightness == Brightness.light
                      ? CustomColors.lightModeDescriptionColor
                      : CustomColors.darkModeDescriptionColor,
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(postData: widget.data),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    "Add Comments",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                              : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                        ),
                  ),
                ),
              );
            }
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(postData: widget.data),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  "View all ${snapshot.data!.docs.length} comments",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                            : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                      ),
                ),
              ),
            );
          });
    });
  }

  getComments() async {
    PostCardNotifier notifier = Provider.of<PostCardNotifier>(context, listen: false);
    await notifier.getCommentsStream(postId: widget.data['postId']);
  }
}
