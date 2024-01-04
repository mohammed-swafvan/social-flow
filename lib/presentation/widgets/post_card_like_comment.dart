import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_icons.dart';
import 'package:social_flow/presentation/utils/like_animation.dart';
import 'package:social_flow/provider/post_card_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class PostCardLikeComment extends StatefulWidget {
  const PostCardLikeComment({super.key, required this.postData, required this.isCurrentUser});
  final Map<String, dynamic> postData;
  final bool isCurrentUser;

  @override
  State<PostCardLikeComment> createState() => _PostCardLikeCommentState();
}

class _PostCardLikeCommentState extends State<PostCardLikeComment> {
  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final List likes = widget.postData['likes'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(bottom: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<PostCardNotifier>(
            builder: (context, notifier, _) {
              return Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await notifier.likePost(postId: widget.postData['postId'], likes: widget.postData['likes']);
                    },
                    child: LikeAnimation(
                      isAnimating: true,
                      smallIcon: true,
                      child: likes.contains(auth.currentUser!.uid)
                          ? const GradientIcon(icon: Icon(Icons.favorite, size: 28))
                          : Icon(
                              Icons.favorite_outline_rounded,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor
                                  : CustomColors.darkModeDescriptionColor,
                              size: 28,
                            ),
                    ),
                  ),
                  CustomSize.width15,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(postData: widget.postData),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.comment_outlined,
                      size: 28,
                      color: Theme.of(context).brightness == Brightness.light
                          ? CustomColors.lightModeDescriptionColor
                          : CustomColors.darkModeDescriptionColor,
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: !widget.isCurrentUser,
                    child: StreamBuilder<bool>(
                      stream: notifier.savedPostExistStream,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                          return SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor
                                  : CustomColors.darkModeDescriptionColor,
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            await notifier.savePost(
                              context: context,
                              uid: widget.postData['uid'],
                              postUrl: widget.postData['postUrl'],
                              description: widget.postData['description'],
                              username: widget.postData['username'],
                              postId: widget.postData['postId'],
                              datePublished: widget.postData['datePublished'],
                              likes: widget.postData['likes'],
                            );
                          },
                          child: snapshot.data == true
                              ? const GradientIcon(
                                  icon: Icon(Icons.bookmark_rounded, size: 28),
                                )
                              : Icon(
                                  Icons.bookmark_outline_rounded,
                                  size: 28,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                                      : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          CustomSize.height5,
          Text(
            "${widget.postData['likes'].length} likes",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Future<void> initializeData() async {
    PostCardNotifier notifier = Provider.of<PostCardNotifier>(context, listen: false);
    await notifier.getSavedPostStream(postId: widget.postData['postId']);
  }
}
