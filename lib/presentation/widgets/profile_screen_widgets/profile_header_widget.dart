import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/followers_screen.dart';
import 'package:social_flow/presentation/screens/following_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/flat_button_widget.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
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
                          text: snapshot.data!['username'],
                          style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                        ),
                        snapshot.data!['bio'] == ""
                            ? TextSpan(
                                text: '\n${snapshot.data!['email']}',
                                style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                              )
                            : TextSpan(
                                text: '\n${snapshot.data!['email']} \n${snapshot.data!['bio']}',
                                style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                              ),
                      ],
                    ),
                  ),
                  kWidth10,
                  FirebaseAuth.instance.currentUser!.uid == snapshot.data!['uid']
                      ? const SizedBox()
                      : snapshot.data!['followers'].contains(FirebaseAuth.instance.currentUser!.uid)
                          ? FlatButtonWidget(
                              function: () async {
                                await FirestoreMethods().followUser(
                                  context: context,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  followId: snapshot.data!['uid'],
                                );
                              },
                              bgColor: kBackgroundColor,
                              borderColor: kWhiteColor.withOpacity(0.7),
                              text: "unfollow",
                            )
                          : FlatButtonWidget(
                              function: () async {
                                await FirestoreMethods().followUser(
                                  context: context,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  followId: snapshot.data!['uid'],
                                );
                              },
                              bgColor: kMainColor,
                              borderColor: kWhiteColor.withOpacity(0.7),
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
