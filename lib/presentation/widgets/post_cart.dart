import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/comment_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/like_animation.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/user_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class PostCardWidget extends StatefulWidget {
  const PostCardWidget({super.key, required this.snap, required this.isHomepage});

  final Map<String, dynamic> snap;
  final bool isHomepage;

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    var screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight;
    if (widget.isHomepage) {
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
                    widget.snap['profImage'],
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
                          name: widget.snap['username'],
                          size: 18,
                          fontWeight: FontWeight.w400,
                          textColor: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: kSmallContextsColor,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: CustomTextWidget(
                                  name: "Delete",
                                  textColor: kRedColor,
                                  fontWeight: FontWeight.w500,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                context,
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: kMainColor.withOpacity(0.6),
                      size: 250,
                    ),
                  ),
                )
              ],
            ),
          ),

          //////// Like Comment and save section /////////
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      context,
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
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
                        snap: widget.snap,
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
                  name: "${widget.snap['likes'].length} likes",
                  size: 14,
                  fontWeight: FontWeight.normal,
                  textColor: kWhiteColor.withOpacity(0.9),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(style: customTextStyle(kWhiteColor, 16, FontWeight.bold), children: [
                      TextSpan(
                        text: widget.snap['username'],
                      ),
                      TextSpan(
                        text: '  ${widget.snap['description']}',
                        style: customTextStyle(kWhiteColor.withOpacity(0.9), 15, FontWeight.w500),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: CustomTextWidget(
                name: "view all 200 comments",
                size: 14,
                fontWeight: FontWeight.w200,
                textColor: kWhiteColor.withOpacity(0.7),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextWidget(
              name: DateFormat.yMEd().format(widget.snap['datePublished'].toDate()),
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
