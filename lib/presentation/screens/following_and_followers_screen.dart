import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/bottom_nav.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/user_list_tile.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class FollowingAndFollowersScreen extends StatefulWidget {
  const FollowingAndFollowersScreen({super.key, required this.title, required this.uid});
  final String title;
  final String uid;

  @override
  State<FollowingAndFollowersScreen> createState() => _FollowingAndFollowersScreenState();
}

class _FollowingAndFollowersScreenState extends State<FollowingAndFollowersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialization();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        await getCurrentUserData();
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      getCurrentUserData();
                      Navigator.pop(context);
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
                  CustomSize.width10,
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.socialFlowLabelColor,
                          overflow: TextOverflow.ellipsis,
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
                  child: Consumer<FollowAndFollowingNotifier>(builder: (context, notifier, _) {
                    if (notifier.isLoading) {
                      return const Center(
                        child: GradientCircularProgressIndicator(),
                      );
                    }

                    if (notifier.users.isEmpty) {
                      return Center(
                        child: Text(
                          "No ${widget.title}",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).brightness == Brightness.light
                                    ? CustomColors.lightModeDescriptionColor
                                    : CustomColors.darkModeDescriptionColor,
                              ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        UserModel user = notifier.users[index];
                        return InkWell(
                          onTap: () {
                            bool isCurrentUser = AuthServices().isCurrentUser(uid: user.uid);
                            if (!isCurrentUser) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(uid: user.uid),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNav(uid: user.uid, initialeTabValue: 3),
                                ),
                              );
                            }
                          },
                          child: UserListTile(user: user, isFollowScreens: true),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 26,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Divider(
                              thickness: 1,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                                  : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      itemCount: notifier.users.length,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initialization() async {
    FollowAndFollowingNotifier notifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await notifier.getTargeteUsers(title: widget.title, uid: widget.uid);
  }

  getCurrentUserData() async {
    ProfileNotifier profileNotifier = Provider.of<ProfileNotifier>(context, listen: false);
    FollowAndFollowingNotifier notifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await profileNotifier.getData(context: context, uid: widget.uid);
    await profileNotifier.getUserPost(uid: widget.uid);
    await profileNotifier.getUserSavedPost(uid: widget.uid);
    await notifier.getUserStream();
  }
}
