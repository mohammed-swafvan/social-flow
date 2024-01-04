import 'package:flutter/material.dart';
import 'package:social_flow/theme/custom_colors.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          CustomColors.firstGradientColor,
          CustomColors.secondGradientColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
