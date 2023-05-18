import 'package:flutter/material.dart';
import 'package:social_flow/utils/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        color: kWhiteColor,
        strokeWidth: 3,
      ),
    );
  }
}
