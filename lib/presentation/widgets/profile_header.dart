import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/chat_screen.dart';
import 'package:social_flow/presentation/screens/edit_screen.dart';
import 'package:social_flow/presentation/screens/following_and_followers_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_text.dart';
import 'package:social_flow/presentation/utils/shimmer_profile_header.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/chat_notifier.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.isCurrentUser});
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(18),
      child: Consumer<ProfileNotifier>(builder: (context, notifier, _) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(notifier.userData['uid']).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.data!.data() == null) {
                notifier.loading = true;
                return const ShimmerProfileheader();
              }

              notifier.loading = false;
              final Map<String, dynamic>? snap = snapshot.data!.data();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: CachedNetworkImage(
                                imageUrl: snap!['photoUrl'],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 80),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isCurrentUser,
                            child: Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () async {
                                  await notifier.updataProfilePhoto(context: context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: CustomColors.scaffoldBackgroundColor,
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: CustomColors.socialFlowLabelColor,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      statColumn(context: context, text: "Posts", count: "${notifier.postLength}"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FollowingAndFollowersScreen(title: "Followers", uid: snap['uid']),
                            ),
                          );
                        },
                        child: statColumn(context: context, text: "Followers", count: "${snap['followers'].length}"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FollowingAndFollowersScreen(title: "Following", uid: snap['uid']),
                            ),
                          );
                        },
                        child: statColumn(context: context, text: "Following", count: "${snap['following'].length}"),
                      ),
                    ],
                  ),
                  isCurrentUser
                      ? currentUserRow(context: context, snap: snap, screenWidth: screenWidth)
                      : otheruserRow(context: context, snap: snap, screenWidth: screenWidth),
                ],
              );
            });
      }),
    );
  }

  Row currentUserRow({required BuildContext context, required Map<String, dynamic> snap, required double screenWidth}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snap['name'].isEmpty ? snap['username'] : snap['name'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              Text(
                snap['email'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
              ),
              snap['category'].isEmpty
                  ? Text(
                      'No Category',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).brightness == Brightness.light
                                ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                                : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                          ),
                    )
                  : Text(
                      snap['category'],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                    ),
              snap['bio'].isEmpty
                  ? Text(
                      'No Bio',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                              : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                          overflow: TextOverflow.ellipsis),
                    )
                  : Text(
                      snap['bio'],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                    ),
            ],
          ),
        ),
        CustomSize.width10,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditScreen(),
                  ),
                );
              },
              child: customButton(
                context: context,
                text: Text(
                  "Edit profile",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row otheruserRow({required BuildContext context, required Map<String, dynamic> snap, required double screenWidth}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snap['name'].isEmpty ? snap['username'] : snap['name'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              Text(
                snap['email'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
              ),
              snap['category'].isEmpty
                  ? Text(
                      'No Category',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).brightness == Brightness.light
                                ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                                : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                          ),
                    )
                  : Text(
                      snap['category'],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                    ),
              snap['bio'].isEmpty
                  ? Text(
                      'No Bio',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                              : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                          overflow: TextOverflow.ellipsis),
                    )
                  : Text(
                      snap['bio'],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
                    ),
            ],
          ),
        ),
        CustomSize.width5,
        Consumer<FollowAndFollowingNotifier>(builder: (context, followFollowingNotifier, _) {
          return StreamBuilder<Object>(
            stream: followFollowingNotifier.userStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                return Expanded(
                  child: customButton(
                    context: context,
                    text: GradientText(
                      gradient: const LinearGradient(
                        colors: [
                          CustomColors.firstGradientColor,
                          CustomColors.secondGradientColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      text: "loading...",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                );
              }
              List following = snapshot.data['following'];
              return Expanded(
                child: InkWell(
                    onTap: () async {
                      await followFollowingNotifier.followUser(context: context, uid: snap['uid']);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: following.contains(snap['uid']) ? 0 : 22),
                      child: customButton(
                        context: context,
                        text: GradientText(
                          gradient: const LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          text: followFollowingNotifier.isFollowLoading
                              ? 'loading...'
                              : following.contains(snap['uid'])
                                  ? "Following"
                                  : "Follow",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: followFollowingNotifier.isFollowLoading ? FontWeight.w600 : FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    )),
              );
            },
          );
        }),
        CustomSize.width5,
        Consumer<FollowAndFollowingNotifier>(builder: (context, followFollowingNotifier, _) {
          return StreamBuilder<Object>(
              stream: followFollowingNotifier.userStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                List following = snapshot.data['following'];

                if (following.contains(snap['uid'])) {
                  return Expanded(
                    child: Consumer<ChatNotifier>(builder: (context, chatNotifier, _) {
                      return InkWell(
                        onTap: () {
                          UserModel user = UserModel(
                            uid: snap['uid'],
                            username: snap['username'],
                            name: snap['name'],
                            email: snap['email'],
                            photoUrl: snap['photoUrl'],
                            bio: snap['bio'],
                            category: snap['category'],
                            followers: snap['followers'],
                            following: snap['following'],
                          );
                          chatNotifier.getChatRoomId(user: user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(user: user),
                            ),
                          );
                        },
                        child: customButton(
                          context: context,
                          text: Text(
                            "Message",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                        ),
                      );
                    }),
                  );
                }

                return const SizedBox.shrink();
              });
        }),
      ],
    );
  }

  Column statColumn({required BuildContext context, required String text, required String count}) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  customButton({required BuildContext context, required Widget text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).brightness == Brightness.light
            ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
            : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
      ),
      child: Center(child: text),
    );
  }
}
