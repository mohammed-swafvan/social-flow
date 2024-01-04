import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/widgets/post_card_header.dart';
import 'package:social_flow/presentation/widgets/post_card_image.dart';
import 'package:social_flow/presentation/widgets/post_card_like_comment.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/post_card_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.postData});
  final Map<String, dynamic> postData;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    inatializingData(postId: widget.postData['postId']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String uid = AuthServices().getUserId();
    bool isCurrentUser = true;
    if (uid == widget.postData['uid']) {
      isCurrentUser = true;
    } else {
      isCurrentUser = false;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 12),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                  : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          width: screenWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostCardHeader(postData: widget.postData),
              CustomSize.height10,
              PostCardImage(postData: widget.postData, imageHeight: screenWidth),
              PostCardLikeComment(isCurrentUser: isCurrentUser, postData: widget.postData),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: screenWidth,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                            ),
                        text: widget.postData['username'],
                      ),
                      TextSpan(
                        text: '  ${widget.postData['description']}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor
                                  : CustomColors.darkModeDescriptionColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  DateFormat.yMEd().format(widget.postData['datePublished'].toDate()),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.light
                            ? CustomColors.lightModeDescriptionColor.withOpacity(0.4)
                            : CustomColors.darkModeDescriptionColor.withOpacity(0.4),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> inatializingData({required String postId}) async {
    PostCardNotifier notifier = Provider.of<PostCardNotifier>(context, listen: false);
    FollowAndFollowingNotifier followFollowingNotifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await followFollowingNotifier.getUserStream();
    await notifier.getSavedPostStream(postId: postId);
  }
}
