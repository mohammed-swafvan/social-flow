// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/settings_screen.dart';
import 'package:social_flow/presentation/screens/splash_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/my_delagate_widget.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/post_in_profile_widget.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/profile_header_widget.dart';
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
    if (widget.uid != 'guest') {
      Provider.of<ProfileScreenProvider>(context, listen: false).uid = widget.uid;
      getUserData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileScreenProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    if (widget.uid == 'guest') {
      return Center(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const Main(),
              ),
              (context) => false,
            );
          },
          icon: Icon(
            Icons.person_add,
            size: 40,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
      );
    }

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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 26,
                          color: kWhiteColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  )
                : AppBar(
                    backgroundColor: kBackgroundColor,
                    leading: Consumer<ProfileScreenProvider>(builder: (context, value, _) {
                      return IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      );
                    }),
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
                  ),
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    Consumer<ProfileScreenProvider>(builder: (context, value, _) {
                      double height;
                      if (value.userData['category'].isEmpty) {
                        height = screenHeight * 0.22;
                      } else {
                        height = screenHeight * 0.25;
                      }
                      return SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: kBackgroundColor,
                        collapsedHeight: height,
                        expandedHeight: height,
                        flexibleSpace: ProfileHeaderWidget(
                          uid: widget.uid,
                        ),
                      );
                    }),
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
              ),
            ),
          );
  }

  getUserData() async {
    await Provider.of<ProfileScreenProvider>(context, listen: false).getData(context, widget.uid);
  }
}
