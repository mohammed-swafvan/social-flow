import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/bottom_text_field.dart';
import 'package:social_flow/presentation/widgets/comment_card.dart';
import 'package:social_flow/provider/commet_notifier.dart';
import 'package:social_flow/provider/user_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key, required this.postData});
  final Map<String, dynamic> postData;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommentNotifier>(context, listen: false).getCommentStream(postId: postData['postId']);
    });
    final UserModel user = Provider.of<UserNotifier>(context).getUser;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
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
                  "Comments",
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
              padding: const EdgeInsets.all(16).copyWith(top: 4),
              width: screenWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<CommentNotifier>(builder: (context, notifier, _) {
                      return SizedBox(
                        child: StreamBuilder(
                            stream: notifier.commetsStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting || notifier.commetsStream == null) {
                                return const Center(
                                  child: GradientCircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Comments',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? CustomColors.lightModeDescriptionColor
                                              : CustomColors.darkModeDescriptionColor,
                                        ),
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final Map<String, dynamic> snap = snapshot.data!.docs[index].data();
                                  return CommentCard(commentSnap: snap, postSnap: postData);
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            }),
                      );
                    }),
                  ),
                  CustomSize.height5,
                  Consumer<CommentNotifier>(builder: (context, notifier, _) {
                    return BottomTextField(
                      controller: notifier.commentController,
                      hintText: "Write a comment...",
                      user: user,
                      isCommentTextField: true,
                      sendButtonPressed: () async {
                        await notifier.sendComment(
                          context: context,
                          postId: postData['postId'],
                          comment: notifier.commentController.text,
                          userProfPic: user.photoUrl,
                          username: user.username,
                          userUid: user.uid,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
}
