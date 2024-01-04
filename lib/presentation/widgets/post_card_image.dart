import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/gradient_icons.dart';
import 'package:social_flow/presentation/utils/like_animation.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/post_card_notifier.dart';

class PostCardImage extends StatelessWidget {
  const PostCardImage({super.key, required this.postData, required this.imageHeight});
  final Map<String, dynamic> postData;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<PostCardNotifier>(
      builder: (context, postCardNotifer, _) {
        return InkWell(
          onDoubleTap: () async{
            postCardNotifer.likeAnimation = true;
            await postCardNotifer.likePost(postId: postData['postId'], likes: postData['likes']);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(2),
                shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade600,
                child: Container(
                  width: screenWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: CachedNetworkImage(
                      imageUrl: postData['postUrl'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Utils().postCardImageShimmer(
                        screenWidth: screenWidth,
                        screenHeight: imageHeight,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: postCardNotifer.isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: postCardNotifer.isLikeAnimating,
                  duration: const Duration(milliseconds: 600),
                  onEnd: () {
                    postCardNotifer.likeAnimation = false;
                  },
                  child: const GradientIcon(
                    icon: Icon(
                      Icons.favorite,
                      size: 200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
