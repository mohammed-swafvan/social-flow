import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/add_post_screen.dart';
import 'package:social_flow/presentation/screens/home_screen.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/screens/search_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/providers/bottom_nav_provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    List<Widget> homeScreenItems = [
      const HomeScreen(),
      const SearchScreen(),
      const AddPostScreen(),
      ProfileScreen(
        uid: userId,
        isCurrentUserProfile: true,
      ),
    ];
    return Scaffold(
      body: Consumer<BottomNavProvider>(
        builder: (context, value, _) {
          return homeScreenItems[value.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(builder: (context, value, _) {
        return CupertinoTabBar(
          activeColor: kMainColor,
          inactiveColor: kMainColor,
          currentIndex: value.currentIndex,
          backgroundColor: kBackgroundColor,
          onTap: (index) {
            value.onButtonIconClick(index);
          },
          items: [
            bottomNavItems(
              navIcon: value.currentIndex == 0 ? Icons.home : Icons.home_outlined,
              currentPage: 0,
              page: value.currentIndex,
            ),
            bottomNavItems(
              navIcon: value.currentIndex == 1 ? Icons.search : Icons.search_outlined,
              currentPage: 1,
              page: value.currentIndex,
            ),
            bottomNavItems(
              navIcon: value.currentIndex == 2 ? Icons.add_circle : Icons.add,
              currentPage: 2,
              page: value.currentIndex,
            ),
            bottomNavItems(
              navIcon: value.currentIndex == 3 ? Icons.person : Icons.person_outline,
              currentPage: 3,
              page: value.currentIndex,
            ),
          ],
        );
      }),
    );
  }
}
