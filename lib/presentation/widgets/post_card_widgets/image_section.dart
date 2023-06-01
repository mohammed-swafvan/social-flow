import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/like_animation.dart';
import 'package:social_flow/providers/post_card_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class ImageSectionWidget extends StatelessWidget {
  const ImageSectionWidget({
    super.key,
    required this.snap,
    required this.user,
    required this.imageHeight,
  });

  final Map<String, dynamic> snap;
  final UserModel? user;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostCardProvider>(
      builder: (context, value, _) {
        return GestureDetector(
          onDoubleTap: () async {
            await FirestoreMethods().likePost(
              context,
              snap['postId'],
              user!.uid,
              snap['likes'],
            );
            value.likeAnimationTrue();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: imageHeight,
                child: Image.network(
                  snap['postUrl'],
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: value.isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: value.isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    value.likeAnimationFalse();
                  },
                  child: Icon(
                    Icons.favorite,
                    color: kMainColor.withOpacity(0.35),
                    size: 200,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

