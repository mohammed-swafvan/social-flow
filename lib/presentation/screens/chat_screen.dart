import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/chat_card.dart';
import 'package:social_flow/presentation/widgets/bottom_text_field.dart';
import 'package:social_flow/presentation/widgets/date_divider.dart';
import 'package:social_flow/provider/chat_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatNotifier>(context, listen: false).getChatStream();
    });
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(uid: user.uid)),
                    );
                  },
                  child: SizedBox(
                    width: 38,
                    height: 38,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38),
                      child: CachedNetworkImage(
                        imageUrl: user.photoUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 38),
                      ),
                    ),
                  ),
                ),
                CustomSize.width5,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(uid: user.uid)),
                    );
                  },
                  child: Text(
                    user.username,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.socialFlowLabelColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16).copyWith(top: 0),
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
                    child: Consumer<ChatNotifier>(builder: (context, notifier, _) {
                      return StreamBuilder(
                          stream: notifier.chatStream,
                          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting ||
                                notifier.chatStream == null ||
                                notifier.isLoading) {
                              return const Center(
                                child: GradientCircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Chats',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? CustomColors.lightModeDescriptionColor
                                            : CustomColors.darkModeDescriptionColor,
                                      ),
                                ),
                              );
                            }

                            notifier.addDate(chatDocs: snapshot.data!.docs);

                            return ListView.separated(
                              reverse: true,
                              itemBuilder: (context, index) {
                                String previousDate;
                                if (index < snapshot.data!.docs.length - 1) {
                                  previousDate = DateFormat.yMMMMEEEEd().format(notifier.chats[index + 1].createdOn);
                                } else {
                                  previousDate = "";
                                }
                                String date = DateFormat.yMMMMEEEEd().format(notifier.chats[index].createdOn);
                                return previousDate != date
                                    ? DateDivider(chat: notifier.chats[index])
                                    : ChatCard(chat: notifier.chats[index]);
                              },
                              separatorBuilder: (context, index) => CustomSize.height5,
                              itemCount: notifier.chats.length,
                            );
                          });
                    }),
                  ),
                  CustomSize.height5,
                  Consumer<ChatNotifier>(
                    builder: (context, notifier, _) {
                      return BottomTextField(
                        user: user,
                        isCommentTextField: false,
                        controller: notifier.messageController,
                        hintText: "Write a message...",
                        sendButtonPressed: () async {
                          await notifier.onMessageSent(chatRoomId: notifier.chatRoomId);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
