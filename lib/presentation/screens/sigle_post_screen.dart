import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/like_animation.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/post_card_provider.dart';
import 'package:social_flow/providers/single_post_provider.dart';

class SinglePostScreen extends StatelessWidget {
  const SinglePostScreen({super.key, required this.snap});

  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SinglePostProvider>(context, listen: false);
      provider.likeContains(snap, FirebaseAuth.instance.currentUser!.uid);
      provider.likeLengthInitializing(snap);
    });

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: "Post",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
        
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PostCardProvider>(
              builder: (context, value, _) {
                return Consumer<SinglePostProvider>(
                  builder: (context, singlePostProv, child) {
                    return GestureDetector(
                      onDoubleTap: () async {
                        await singlePostProv.likePost(context, snap, currentUserUid);
                        singlePostProv.likeButtonManaging();
                        singlePostProv.likeLengthCounting();
                        value.likeAnimationTrue();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: screenHeight * 0.7,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(snap['postUrl']),
                                fit: BoxFit.cover,
                              ),
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
              },
            ),
            Row(
              children: [
                Consumer<SinglePostProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: () async {
                        await value.likePost(context, snap, currentUserUid);
                        value.likeLengthCounting();
                        value.likeButtonManaging();
                      },
                      icon: value.alreadyLike
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
                    );
                  },
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
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<SinglePostProvider>(
                    builder: (context, value, child) {
                      return CustomTextWidget(
                        name: "${value.likeLength} likes",
                        size: 14,
                        fontWeight: FontWeight.normal,
                        textColor: kWhiteColor.withOpacity(0.9),
                      );
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(style: customTextStyle(kWhiteColor, 16, FontWeight.bold), children: [
                        TextSpan(
                          text: snap['username'],
                        ),
                        TextSpan(
                          text: '  ${snap['description']}',
                          style: customTextStyle(kWhiteColor.withOpacity(0.9), 15, FontWeight.w500),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomTextWidget(
                name: DateFormat.yMEd().format(snap['datePublished'].toDate()),
                size: 12,
                fontWeight: FontWeight.w200,
                textColor: kWhiteColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
