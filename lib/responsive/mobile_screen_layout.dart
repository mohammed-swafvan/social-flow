import 'package:flutter/material.dart';
import 'package:social_flow/utils/colors.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is Mobile",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
    );
  }
}
