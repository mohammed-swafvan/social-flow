import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_icons.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/commet_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.commentSnap, required this.postSnap});
  final Map<String, dynamic> postSnap;
  final Map<String, dynamic> commentSnap;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentNotifier>(builder: (context, notifier, _) {
      return InkWell(
        onDoubleTap: () async {
          final String currentUid = FirebaseAuth.instance.currentUser!.uid;
          if (currentUid == postSnap['uid']) {
            await notifier.likeComment(postId: postSnap['postId'], commentId: commentSnap['comment_id']);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: CachedNetworkImage(
                    imageUrl: commentSnap['profile_pic'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 36),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            commentSnap['username'],
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                          Visibility(
                            visible: commentSnap['is_author_liked'],
                            child: Text(
                              "  • ",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? CustomColors.lightModeDescriptionColor
                                        : CustomColors.darkModeDescriptionColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ),
                          Visibility(
                            visible: commentSnap['is_author_liked'],
                            child: const GradientIcon(
                              icon: Icon(
                                Icons.favorite,
                                size: 12,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: commentSnap['is_author_liked'],
                            child: Text(
                              " by author",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? CustomColors.lightModeDescriptionColor
                                        : CustomColors.darkModeDescriptionColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      CustomSize.height5,
                      Text(
                        commentSnap['comment'],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.jm().format(commentSnap['date_created'].toDate()),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor
                              : CustomColors.darkModeDescriptionColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(commentSnap['date_created'].toDate()),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor
                              : CustomColors.darkModeDescriptionColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
