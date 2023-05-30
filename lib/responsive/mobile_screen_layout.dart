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
  late PageController pageController;
  int pages = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: kBackgroundColor,
        onTap: navigationTapped,
        items: [
          bottomNavItems(navIcon: Icons.home, currentPage: 0, pages: pages),
          bottomNavItems(navIcon: Icons.search, currentPage: 1, pages: pages),
          bottomNavItems(navIcon: Icons.add_circle, currentPage: 2, pages: pages),
          bottomNavItems(navIcon: Icons.person, currentPage: 3, pages: pages),
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int changingPage) {
    setState(() {
      pages = changingPage;
    });
  }
}
