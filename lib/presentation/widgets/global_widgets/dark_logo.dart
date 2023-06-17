import 'package:flutter/material.dart';

class DarkLogoWidget extends StatelessWidget {
  const DarkLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.7,
      height: screenWidth * 0.7,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(200)),
          image: DecorationImage(image: AssetImage("assets/images/Social_flow_dark_theme.jpg"), fit: BoxFit.fill)),
    );
  }
}
