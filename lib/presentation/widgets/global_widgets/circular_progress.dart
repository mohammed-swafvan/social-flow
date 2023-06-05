import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29,
      width: 29,
      child: CircularProgressIndicator(
        color: kWhiteColor,
        strokeWidth: 3,
      ),
    );
  }
}
