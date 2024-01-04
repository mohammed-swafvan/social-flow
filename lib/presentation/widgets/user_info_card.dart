import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/gradient_text.dart';
import 'package:social_flow/theme/custom_colors.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key, required this.labelText, required this.text, required this.valueIsEmpty});
  final String labelText;
  final String text;
  final bool valueIsEmpty;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: Theme.of(context).brightness == Brightness.light
              ? CustomColors.lightModeDescriptionColor.withOpacity(0.3)
              : CustomColors.darkModeDescriptionColor.withOpacity(0.3),
        ),
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
      ),
      child: Row(
        children: [
          Text(
            "$labelText :  ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: screenWidth / 1.7,
            child: valueIsEmpty
                ? Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).brightness == Brightness.light
                              ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                              : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                        ),
                  )
                : GradientText(
                    text: text,
                    gradient: const LinearGradient(
                      colors: [
                        CustomColors.firstGradientColor,
                        CustomColors.secondGradientColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
