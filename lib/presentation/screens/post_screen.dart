import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/post_card_image.dart';
import 'package:social_flow/presentation/widgets/post_card_like_comment.dart';
import 'package:social_flow/presentation/widgets/post_commet_lenth.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').doc(postId).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: GradientCircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Posts',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).brightness == Brightness.light
                            ? CustomColors.lightModeDescriptionColor
                            : CustomColors.darkModeDescriptionColor,
                      ),
                ),
              );
            }
            final String currentUserId = AuthServices().getUserId();
            final String uid = snapshot.data!.data()!['uid'];
            bool isCurrentUser = false;
            if (currentUserId == uid) {
              isCurrentUser = true;
            } else {
              isCurrentUser = false;
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6).copyWith(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).brightness == Brightness.light
                                ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                                : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: CustomColors.socialFlowLabelColor,
                          ),
                        ),
                      ),
                      CustomSize.width15,
                      Text(
                        snapshot.data!['username'],
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.socialFlowLabelColor,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostCardImage(postData: snapshot.data!.data()!, imageHeight: screenHeight / 1.6),
                            PostCardLikeComment(isCurrentUser: isCurrentUser, postData: snapshot.data!.data()!),
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
                                      text: snapshot.data!['username'],
                                    ),
                                    TextSpan(
                                      text: '  "${snapshot.data!['description']}',
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
                            PostCommentLength(data: snapshot.data!.data()!),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                DateFormat.yMEd().format(snapshot.data!['datePublished'].toDate()),
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
                  ),
                ),
              ],
            );
          }),
    );
  }
}
