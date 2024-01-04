import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/menu_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/profile_delegate.dart';
import 'package:social_flow/presentation/widgets/profile_header.dart';
import 'package:social_flow/presentation/widgets/profile_posts.dart';
import 'package:social_flow/presentation/widgets/profile_saved_post.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    bool isCurrentUser = AuthServices().isCurrentUser(uid: widget.uid);
    return Consumer<ProfileNotifier>(builder: (context, notifier, _) {
      return Scaffold(
        backgroundColor: notifier.userData['username'] == null
            ? Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black
            : CustomColors.scaffoldBackgroundColor,
        body: notifier.userData['username'] == null
            ? const Center(
                child: GradientCircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Consumer<ProfileNotifier>(builder: (context, notifier, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !isCurrentUser
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
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
                                      notifier.userData['username'],
                                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.socialFlowLabelColor,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                  ],
                                )
                              : Text(
                                  notifier.userData['username'],
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.socialFlowLabelColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                          Visibility(
                            visible: isCurrentUser,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MenuScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                                      : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
                                ),
                                child: const Icon(
                                  Icons.menu_rounded,
                                  color: CustomColors.socialFlowLabelColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
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
                        child: Consumer<ProfileNotifier>(builder: (context, notifier, _) {
                          if (notifier.isLoading) {
                            return const Center(
                              child: GradientCircularProgressIndicator(),
                            );
                          }
                          return DefaultTabController(
                            length: 2,
                            child: NestedScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              headerSliverBuilder: (context, innerBoxIsScrolled) {
                                double appBarHeight = screenHeight * 0.26;
                                return [
                                  SliverAppBar(
                                    automaticallyImplyLeading: false,
                                    backgroundColor: Colors.transparent,
                                    collapsedHeight: appBarHeight,
                                    expandedHeight: appBarHeight,
                                    flexibleSpace: ProfileHeader(isCurrentUser: isCurrentUser),
                                  ),
                                  SliverPersistentHeader(
                                    floating: true,
                                    pinned: true,
                                    delegate: ProfileDelegate(
                                      tabBarColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                                      tabBar: TabBar(
                                        dividerColor: Colors.transparent,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicatorColor: CustomColors.firstGradientColor.withOpacity(0.8),
                                        labelColor: CustomColors.firstGradientColor.withOpacity(0.8),
                                        unselectedLabelColor: Theme.of(context).brightness == Brightness.light
                                            ? CustomColors.lightModeDescriptionColor.withOpacity(0.5)
                                            : CustomColors.darkModeDescriptionColor.withOpacity(0.5),
                                        tabs: const [
                                          Tab(
                                            icon: Icon(Icons.grid_on),
                                          ),
                                          Tab(
                                            icon: Icon(Icons.bookmark),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              body: TabBarView(
                                children: [
                                  ProfilePost(isCurrentUser: isCurrentUser),
                                  const ProfileSavedPost(),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  getCurrentUserData() async {
    ProfileNotifier notifier = Provider.of<ProfileNotifier>(context, listen: false);
    FollowAndFollowingNotifier followFollowingNotifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await notifier.getData(context: context, uid: widget.uid);
    await notifier.getUserPost(uid: widget.uid);
    await notifier.getUserSavedPost(uid: widget.uid);
    await followFollowingNotifier.getUserStream();
  }
}
