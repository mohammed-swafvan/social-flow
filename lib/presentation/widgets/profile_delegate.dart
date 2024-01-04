import 'package:flutter/material.dart';

class ProfileDelegate extends SliverPersistentHeaderDelegate {
  ProfileDelegate({required this.tabBarColor, required this.tabBar});

  final TabBar tabBar;
  final Color tabBarColor;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: tabBarColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
