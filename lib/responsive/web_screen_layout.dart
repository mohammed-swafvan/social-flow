import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is Web",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
    );
  }
}
