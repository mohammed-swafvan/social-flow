import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/follow_button.dart';
import 'package:social_flow/provider/bottom_nav_notifer.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({super.key, required this.postData});
  final Map<String, dynamic> postData;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    bool isCurrentUser = postData['uid'] == auth.currentUser!.uid ? true : false;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(right: 14),
      child: Consumer<BottomNavNotifier>(builder: (context, bottomNavNotifier, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (!isCurrentUser) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(uid: postData['uid']),
                    ),
                  );
                } else {
                  bottomNavNotifier.onPageChanged(3);
                }
              },
              child: SizedBox(
                width: 38,
                height: 38,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: CachedNetworkImage(
                    imageUrl: postData['profImage'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 38),
                  ),
                ),
              ),
            ),
            CustomSize.width5,
            Expanded(
              child: InkWell(
                onTap: () {
                  if (!isCurrentUser) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: postData['uid']),
                      ),
                    );
                  } else {
                    bottomNavNotifier.onPageChanged(3);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    postData['username'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !isCurrentUser,
              child: Consumer<FollowAndFollowingNotifier>(builder: (context, followNotifier, _) {
                return StreamBuilder<Object>(
                  stream: followNotifier.userStream,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                      return FollowButton(
                        text: 'waiting...',
                        textStyle: followNotifier.isFollowLoading
                            ? Theme.of(context).textTheme.bodyMedium!
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      );
                    }
                    List following = snapshot.data['following'];
                    return InkWell(
                      onTap: () async {
                        await followNotifier.followUser(context: context, uid: postData['uid']);
                      },
                      child: FollowButton(
                        text: followNotifier.isFollowLoading
                            ? 'waiting...'
                            : following.contains(postData['uid'])
                                ? "Following"
                                : "Follow",
                        textStyle: followNotifier.isFollowLoading
                            ? Theme.of(context).textTheme.bodyMedium!
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
