import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';

class MyDelagatWidget extends SliverPersistentHeaderDelegate {
  MyDelagatWidget({required this.tabBar});

  final TabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: kBackgroundColor,
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
