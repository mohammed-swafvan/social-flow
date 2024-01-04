import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/chat_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/user_list_tile.dart';
import 'package:social_flow/provider/chat_notifier.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
                  "Chats",
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
                child: Consumer<FollowAndFollowingNotifier>(builder: (context, followingNotifier, _) {
                  if (followingNotifier.isLoading) {
                    return const Center(
                      child: GradientCircularProgressIndicator(),
                    );
                  }

                  if (followingNotifier.users.isEmpty) {
                    return Center(
                      child: Text(
                        "No Chats",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor
                                  : CustomColors.darkModeDescriptionColor,
                            ),
                      ),
                    );
                  }
                  return Consumer<ChatNotifier>(builder: (context, notifier, _) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        UserModel user = followingNotifier.users[index];
                        return InkWell(
                          onTap: () {
                            notifier.getChatRoomId(user: user);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(user: user),
                              ),
                            );
                          },
                          child: UserListTile(user: user, isFollowScreens: false),
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
                      itemCount: followingNotifier.users.length,
                    );
                  });
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initialization() async {
    FollowAndFollowingNotifier followFollowingNotifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    String uid = AuthServices().getUserId();
    await followFollowingNotifier.getTargeteUsers(title: 'following', uid: uid);
  }
}
