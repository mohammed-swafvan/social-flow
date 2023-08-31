import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/message_model.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/presentation/widgets/message_widgets/date_divider_widget.dart';
import 'package:social_flow/presentation/widgets/message_widgets/message_card_widget.dart';
import 'package:social_flow/providers/chat_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.chatRoomId, required this.targatedUser});

  final String chatRoomId;
  final UserModel targatedUser;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  uid: targatedUser.uid,
                  isCurrentUserProfile: false,
                ),
              ),
            );
          },
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(targatedUser.photoUrl),
              ),
              kWidth10,
              CustomTextWidget(
                name: ' ${targatedUser.username}',
                size: 20,
                fontWeight: FontWeight.bold,
                textColor: kWhiteColor,
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('chatRoom')
            .doc(chatRoomId)
            .collection('chats')
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Please Check Your Internet Connection'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressWidget(),
            );
          }

          List<MessageModelTwo> messageModelList = [];
          for (var element in snapshot.data!.docs) {
            DateTime currentDate = DateTime.now();
            DateTime date = element['createdOn'] == null ? currentDate : (element['createdOn'] as Timestamp).toDate();
            messageModelList.add(MessageModelTwo(
              sendBy: element['sendBy'],
              message: element['message'],
              createdOn: date,
              seen: element['seen'],
              chatRoomId: element['chatRoomId'],
              chatId: element['chatId'],
            ));
          }

          return messageModelList.isEmpty
              ? SizedBox(
                  height: screenHeight * 0.8,
                  child: Center(
                    child: CustomTextWidget(
                      name: 'No chats',
                      size: 16,
                      fontWeight: FontWeight.bold,
                      textColor: kWhiteColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    String previousDate;
                    if (index < snapshot.data!.docs.length - 1) {
                      previousDate = DateFormat.yMMMMEEEEd().format(messageModelList[index + 1].createdOn!);
                    } else {
                      previousDate = "";
                    }

                    String date = DateFormat.yMMMMEEEEd().format(messageModelList[index].createdOn!);

                    return previousDate != date
                        ? DateDividerWidget(state: messageModelList[index])
                        : MessageCardWidget(messageDetails: messageModelList[index]);
                  },
                );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor.withOpacity(0.13),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            height: kToolbarHeight * 0.9,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Consumer<ChatProvider>(builder: (context, value, _) {
                      return TextField(
                        controller: value.chatController,
                        style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: customTextStyle(kWhiteColor.withOpacity(0.5), 16, FontWeight.w500),
                          border: InputBorder.none,
                        ),
                      );
                    }),
                  ),
                ),
                Consumer<ChatProvider>(
                  builder: (context, value, _) {
                    return IconButton(
                      onPressed: () async {
                        await value.onMessageSent(
                          userUid: FirebaseAuth.instance.currentUser!.uid,
                          chatRoomId: chatRoomId,
                        );
                        value.disposeChatController();
                      },
                      icon: Icon(
                        Icons.send,
                        color: kWhiteColor,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
