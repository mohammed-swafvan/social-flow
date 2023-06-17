import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/chat_screen.dart';
import 'package:social_flow/presentation/screens/followers_screen.dart';
import 'package:social_flow/presentation/screens/following_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/flat_button_widget.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
import 'package:social_flow/resources/chat_methods.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressWidget(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(snapshot.data!['photoUrl']),
                  ),
                  Consumer<ProfileScreenProvider>(builder: (context, value, _) {
                    return InkWell(
                      child: customStatColumn("${value.postLength}", "Post"),
                    );
                  }),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowersScreen(
                            uid: snapshot.data!['uid'],
                            profileScreenUid: uid,
                          ),
                        ),
                      );
                    },
                    child: customStatColumn(
                      "${snapshot.data!['followers'].length}",
                      "Followers",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowingScreen(
                            uid: snapshot.data!['uid'],
                            profileScreenUid: uid,
                          ),
                        ),
                      );
                    },
                    child: customStatColumn(
                      "${snapshot.data!['following'].length}",
                      "Following",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: snapshot.data!['name'].isEmpty ? snapshot.data!['username'] : snapshot.data!['name'],
                          style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                        ),
                        TextSpan(
                          text: '\n${snapshot.data!['email']}',
                          style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                        ),
                        snapshot.data!['category'].isNotEmpty
                            ? TextSpan(
                                text: '\n${snapshot.data!['category']}',
                                style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                              )
                            : const TextSpan(),
                        snapshot.data!['bio'].isNotEmpty
                            ? TextSpan(
                                text: '\n${snapshot.data!['bio']}',
                                style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                              )
                            : const TextSpan(),
                      ],
                    ),
                  ),
                  kWidth10,
                  FirebaseAuth.instance.currentUser!.uid == snapshot.data!['uid']
                      ? const SizedBox()
                      : snapshot.data!['followers'].contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Expanded(
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    FlatButtonWidget(
                                      function: () {
                                        String chatRoomId = ChatMethods().checkingId(
                                          user: snapshot.data!['uid'],
                                          currentUser: FirebaseAuth.instance.currentUser!.uid,
                                        );
                                        UserModel targatedUser = UserModel(
                                            email: snapshot.data!['email'],
                                            uid: uid,
                                            photoUrl: snapshot.data!['photoUrl'],
                                            username: snapshot.data!['username'],
                                            bio: snapshot.data!['bio'],
                                            followers: snapshot.data!['followers'],
                                            following: snapshot.data!['following'],
                                            name: snapshot.data!['name'],
                                            category: snapshot.data!['category']);
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
                                      bgColor: kBackgroundColor,
                                      text: "message",
                                    ),
                                    FlatButtonWidget(
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                          context: context,
                                          currentUserUid: FirebaseAuth.instance.currentUser!.uid,
                                          followUserId: snapshot.data!['uid'],
                                        );
                                      },
                                      bgColor: kBackgroundColor,
                                      text: "unfollow",
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : FlatButtonWidget(
                              function: () async {
                                await FirestoreMethods().followUser(
                                  context: context,
                                  currentUserUid: FirebaseAuth.instance.currentUser!.uid,
                                  followUserId: snapshot.data!['uid'],
                                );
                              },
                              bgColor: kMainColor,
                              text: "follow",
                            ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
