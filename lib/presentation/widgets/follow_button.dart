import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/gradient_text.dart';
import 'package:social_flow/theme/custom_colors.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key, required this.text, required this.textStyle});
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade600,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? CustomColors.lightModeDescriptionColor.withOpacity(0.4)
                : CustomColors.darkModeDescriptionColor.withOpacity(0.4),
          ),
        ),
        child: GradientText(
          text: text,
          style: textStyle,
          gradient: const LinearGradient(
            colors: [
              CustomColors.firstGradientColor,
              CustomColors.secondGradientColor,
            ],
          ),
        ),
      ),
    );
  }
}
