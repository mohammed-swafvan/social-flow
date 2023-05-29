import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/my_delagate_widget.dart';
import 'package:social_flow/presentation/widgets/post_tab_bar_view.dart';
import 'package:social_flow/presentation/widgets/profile_view_widget.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
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
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: kBackgroundColor,
              title: Consumer<ProfileScreenProvider>(builder: (context, value, _) {
                return CustomTextWidget(
                  name: value.userData['username'],
                  size: 24,
                  fontWeight: FontWeight.bold,
                  textColor: kYellowColor,
                );
              }),
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
                                backgroundColor: kBackgroundColor,
                                collapsedHeight: screenHeight * 0.2,
                                expandedHeight: screenHeight * 0.2,
                                flexibleSpace: const ProfileViewWidget(),
                              )
                            : SliverAppBar(
                                backgroundColor: kBackgroundColor,
                                collapsedHeight: screenHeight * 0.23,
                                expandedHeight: screenHeight * 0.23,
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
                              tabs: const [Tab(icon: Icon(Icons.grid_on)), Tab(icon: Icon(Icons.bookmark))],
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        PostTabBarViewWidget(uid: widget.uid),
                        Container(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }

  getUserData() {
    Provider.of<ProfileScreenProvider>(context, listen: false).getData(widget.uid, context);
  }
}
