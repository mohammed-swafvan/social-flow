import 'package:flutter/material.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SocialFlowLogo extends StatelessWidget {
  const SocialFlowLogo({super.key, required this.backGroundRadius,required this.textStyle});
  final double backGroundRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: backGroundRadius,
        width: backGroundRadius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              CustomColors.firstGradientColor,
              CustomColors.secondGradientColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Text(
            "SF",
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
