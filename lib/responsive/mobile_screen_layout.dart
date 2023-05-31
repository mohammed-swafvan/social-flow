import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenItems[currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        activeColor: kMainColor,
        inactiveColor: kMainColor.withOpacity(0.6),
        currentIndex: currentIndex,
        backgroundColor: kBackgroundColor,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          bottomNavItems(navIcon: Icons.home, currentPage: 0, page: currentIndex),
          bottomNavItems(navIcon: Icons.search, currentPage: 1, page: currentIndex),
          bottomNavItems(navIcon: Icons.add_circle, currentPage: 2, page: currentIndex),
          bottomNavItems(navIcon: Icons.person, currentPage: 3, page: currentIndex),
        ],
      ),
    );
  }
}
