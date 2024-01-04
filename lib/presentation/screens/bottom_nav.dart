import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/create_post_screen.dart';
import 'package:social_flow/presentation/screens/home_screen.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/screens/search_screen.dart';
import 'package:social_flow/presentation/utils/gradient_icons.dart';
import 'package:social_flow/provider/bottom_nav_notifer.dart';
import 'package:social_flow/provider/user_notifier.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.uid, this.initialeTabValue = 0});
  final String uid;
  final int initialeTabValue;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    getUserDetails();
    Provider.of<BottomNavNotifier>(context, listen: false).page = widget.initialeTabValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      const SearchScreen(),
      const CreatePostScreen(),
      ProfileScreen(uid: widget.uid),
    ];

    return Scaffold(
      body: Consumer<BottomNavNotifier>(
        builder: (context, notifier, _) {
          return pages[notifier.page];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavNotifier>(
        builder: (context, notifier, _) {
          return CupertinoTabBar(
            height: kTextTabBarHeight + 8,
            currentIndex: notifier.page,
            onTap: (index) {
              notifier.onPageChanged(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: GradientIcon(
                  icon: Icon(
                    notifier.page == 0 ? Icons.home_rounded : Icons.home_outlined,
                    size: notifier.page == 0 ? 36 : 30,
                  ),
                ),
                tooltip: "Home",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  icon: Icon(
                    notifier.page == 1 ? Icons.search_rounded : Icons.search_off_rounded,
                    size: notifier.page == 1 ? 36 : 30,
                  ),
                ),
                tooltip: "Search",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  icon: Icon(
                    notifier.page == 2 ? Icons.add_circle_rounded : Icons.add_outlined,
                    size: notifier.page == 2 ? 36 : 30,
                  ),
                ),
                tooltip: "Add Post",
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(
                  icon: Icon(
                    notifier.page == 3 ? Icons.person_4_rounded : Icons.person_4_outlined,
                    size: notifier.page == 3 ? 36 : 30,
                  ),
                ),
                tooltip: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }

  void getUserDetails() async {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    await userNotifier.refreshUser();
  }
}
