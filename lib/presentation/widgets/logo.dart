import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';

class SocilaFlowLogo extends StatelessWidget {
  const SocilaFlowLogo({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: kBackgroundColor,
      child: const Image(
        image: AssetImage("assets/images/social_flow.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}
