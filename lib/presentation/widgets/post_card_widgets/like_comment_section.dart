import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/like_animation.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class LikeCommentSection extends StatelessWidget {
  const LikeCommentSection({
    super.key,
    required this.snap,
    required this.user,
  });

  final Map<String, dynamic> snap ;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeAnimation(
          isAnimating: snap['likes'].contains(user!.uid),
          smallLike: true,
          child: IconButton(
            onPressed: () async {
              await FirestoreMethods().likePost(
                context,
                snap['postId'],
                user!.uid,
                snap['likes'],
              );
            },
            icon: snap['likes'].contains(user!.uid)
                ? Icon(
                    Icons.favorite,
                    color: kMainColor,
                    size: 28,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: kWhiteColor.withOpacity(0.8),
                    size: 28,
                  ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentScreen(
                  snap: snap,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.comment_outlined,
            color: kWhiteColor.withOpacity(0.8),
            size: 28,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border,
                color: kWhiteColor.withOpacity(0.8),
                size: 28,
              ),
            ),
          ),
        )
      ],
    );
  }
}

