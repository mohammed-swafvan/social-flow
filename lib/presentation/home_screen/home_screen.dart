import 'package:flutter/material.dart';
import 'package:social_flow/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          "Home",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
    );
  }
}
