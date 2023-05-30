// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/like_animation.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/post_card_provider.dart';
import 'package:social_flow/providers/user_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.snap, required this.isHomepage});

  final Map<String, dynamic> snap;
  final bool isHomepage;

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    var screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight;
    if (isHomepage) {
      imageHeight = screenHeight * 0.47;
    } else {
      imageHeight = screenHeight * 0.55;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ////// Header section ////////
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          name: snap['username'],
                          size: 18,
                          fontWeight: FontWeight.w400,
                          textColor: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await postCardDialogue(isHomepage, snap, context);
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: kWhiteColor.withOpacity(0.8),
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),

          /////// Image section //////
          Consumer<PostCardProvider>(
            builder: (context, value, _) {
              return GestureDetector(
                onDoubleTap: () async {
                  await FirestoreMethods().likePost(
                    context,
                    snap['postId'],
                    user.uid,
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
          ),

          //////// Like Comment and save section /////////
          Row(
            children: [
              LikeAnimation(
                isAnimating: snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      context,
                      snap['postId'],
                      user.uid,
                      snap['likes'],
                    );
                  },
                  icon: snap['likes'].contains(user.uid)
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
          ),

          //////// desribtion and number of cmnts section ///////
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  name: "${snap['likes'].length} likes",
                  size: 14,
                  fontWeight: FontWeight.normal,
                  textColor: kWhiteColor.withOpacity(0.9),
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
          StreamBuilder(
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
    );
  }
}
