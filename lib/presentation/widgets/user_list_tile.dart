import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/follow_button.dart';
import 'package:social_flow/provider/bottom_nav_notifer.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class UserListTile extends StatefulWidget {
  const UserListTile({super.key, required this.user, required this.isFollowScreens});
  final UserModel user;
  final bool isFollowScreens;

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = AuthServices().isCurrentUser(uid: widget.user.uid);
    return Consumer<BottomNavNotifier>(
      builder: (context, bottomNavNotifier, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 46,
                height: 46,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: CachedNetworkImage(
                    imageUrl: widget.user.photoUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 46),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.username,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                      widget.user.name.isNotEmpty
                          ? Text(
                              widget.user.name,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? CustomColors.lightModeDescriptionColor.withOpacity(0.8)
                                        : CustomColors.darkModeDescriptionColor.withOpacity(0.8),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              CustomSize.width5,
              Visibility(
                visible: !isCurrentUser && widget.isFollowScreens,
                child: Consumer<FollowAndFollowingNotifier>(builder: (context, followFollowingNotifier, _) {
                  return StreamBuilder<Object>(
                    stream: followFollowingNotifier.userStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                        return FollowButton(
                          text: 'loading...',
                          textStyle: followFollowingNotifier.isFollowLoading
                              ? Theme.of(context).textTheme.bodyMedium!
                              : Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        );
                      }
                      List following = snapshot.data['following'];
                      return InkWell(
                        onTap: () async {
                          await followFollowingNotifier.followUser(context: context, uid: widget.user.uid);
                        },
                        child: FollowButton(
                          text: followFollowingNotifier.isFollowLoading
                              ? 'loading...'
                              : following.contains(widget.user.uid)
                                  ? "Following"
                                  : "Follow",
                          textStyle: followFollowingNotifier.isFollowLoading
                              ? Theme.of(context).textTheme.labelMedium!
                              : Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> initializeData() async {
    FollowAndFollowingNotifier followFollowingNotifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await followFollowingNotifier.getUserStream();
  }
}
