import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/my_delagate_widget.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/post_in_profile_widget.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/profile_view_widget.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/saved_images_widget.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.uid,
    required this.isCurrentUserProfile,
  });

  final String uid;
  final bool isCurrentUserProfile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileScreenProvider>(context, listen: false).uid = widget.uid;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileScreenProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return provider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: widget.isCurrentUserProfile
                ? AppBar(
                    centerTitle: false,
                    backgroundColor: kBackgroundColor,
                    title: Consumer<ProfileScreenProvider>(
                      builder: (context, value, _) {
                        return CustomTextWidget(
                          name: value.userData['username'],
                          size: 24,
                          fontWeight: FontWeight.bold,
                          textColor: kYellowColor,
                        );
                      },
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.dehaze,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                : AppBar(
                    backgroundColor: kBackgroundColor,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    title: Consumer<ProfileScreenProvider>(
                      builder: (context, value, _) {
                        return CustomTextWidget(
                          name: value.userData['username'],
                          size: 24,
                          fontWeight: FontWeight.bold,
                          textColor: kYellowColor,
                        );
                      },
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.dehaze,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
            body: DefaultTabController(
              length: 2,
              child: Consumer<ProfileScreenProvider>(
                builder: (context, value, child) {
                  return NestedScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, isScrolled) {
                      return [
                        value.userData['bio'] == ""
                            ? SliverAppBar(
                                automaticallyImplyLeading: false,
                                backgroundColor: kBackgroundColor,
                                collapsedHeight: screenHeight * 0.21,
                                expandedHeight: screenHeight * 0.21,
                                flexibleSpace: const ProfileViewWidget(),
                              )
                            : SliverAppBar(
                                automaticallyImplyLeading: false,
                                backgroundColor: kBackgroundColor,
                                collapsedHeight: screenHeight * 0.22,
                                expandedHeight: screenHeight * 0.22,
                                flexibleSpace: const ProfileViewWidget(),
                              ),
                        SliverPersistentHeader(
                          floating: true,
                          pinned: true,
                          delegate: MyDelagatWidget(
                            tabBar: TabBar(
                              indicatorColor: kWhiteColor,
                              unselectedLabelColor: kWhiteColor.withOpacity(0.5),
                              labelColor: kWhiteColor,
                              tabs: const [
                                Tab(icon: Icon(Icons.grid_on)),
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
                        const PostsInProfileWidget(),
                        SavedImagesWidget(uid: widget.uid),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }

  getUserData() {
    Provider.of<ProfileScreenProvider>(context, listen: false).getData(context, widget.uid);
  }
}
