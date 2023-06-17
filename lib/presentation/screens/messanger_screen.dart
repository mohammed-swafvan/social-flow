import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/chat_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/following_screen_provider.dart';
import 'package:social_flow/resources/chat_methods.dart';

class MessangerScreen extends StatelessWidget {
  const MessangerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FollowingScreenProvider>(context, listen: false)
          .getUserFollowing(userUid: FirebaseAuth.instance.currentUser!.uid);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: "Messanger",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Consumer<FollowingScreenProvider>(builder: (contex, value, _) {
        return value.isLoading
            ? const Center(
                child: CircularProgressWidget(),
              )
            : value.userModelList!.isEmpty
                ? Center(
                    child: CustomTextWidget(
                      name: 'No Users',
                      size: 16,
                      fontWeight: FontWeight.bold,
                      textColor: kWhiteColor,
                    ),
                  )
                : ListView.builder(
                    itemCount: value.userModelList!.length,
                    itemBuilder: (context, index) {
                      return value.userModelList![index].name.isNotEmpty
                          ? ListTile(
                              minVerticalPadding: 15,
                              onTap: () {
                                String chatRoomId = ChatMethods().checkingId(
                                  user: value.userModelList![index].uid,
                                  currentUser: FirebaseAuth.instance.currentUser!.uid,
                                );

                                UserModel targatedUser = UserModel(
                                  email: value.userModelList![index].email,
                                  uid: value.userModelList![index].uid,
                                  photoUrl: value.userModelList![index].photoUrl,
                                  username: value.userModelList![index].username,
                                  bio: value.userModelList![index].bio,
                                  followers: value.userModelList![index].followers,
                                  following: value.userModelList![index].following,
                                  name: value.userModelList![index].name,
                                  category: value.userModelList![index].category,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      chatRoomId: chatRoomId,
                                      targatedUser: targatedUser,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(value.userModelList![index].photoUrl),
                              ),
                              title: CustomTextWidget(
                                name: value.userModelList![index].username,
                                size: 18,
                                fontWeight: FontWeight.bold,
                                textColor: kWhiteColor,
                              ),
                              subtitle: CustomTextWidget(
                                name: value.userModelList![index].name,
                                size: 14,
                                fontWeight: FontWeight.w400,
                                textColor: kWhiteColor.withOpacity(0.6),
                              ),
                            )
                          : ListTile(
                              minVerticalPadding: 15,
                              onTap: () {
                                String chatRoomId = ChatMethods().checkingId(
                                  user: value.userModelList![index].uid,
                                  currentUser: FirebaseAuth.instance.currentUser!.uid,
                                );

                                UserModel targatedUser = UserModel(
                                  email: value.userModelList![index].email,
                                  uid: value.userModelList![index].uid,
                                  photoUrl: value.userModelList![index].photoUrl,
                                  username: value.userModelList![index].username,
                                  bio: value.userModelList![index].bio,
                                  followers: value.userModelList![index].followers,
                                  following: value.userModelList![index].following,
                                  name: value.userModelList![index].name,
                                  category: value.userModelList![index].category,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      chatRoomId: chatRoomId,
                                      targatedUser: targatedUser,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(value.userModelList![index].photoUrl),
                              ),
                              title: CustomTextWidget(
                                name: value.userModelList![index].username,
                                size: 18,
                                fontWeight: FontWeight.bold,
                                textColor: kWhiteColor,
                              ),
                            );
                    },
                  );
      }),
    );
  }
}
