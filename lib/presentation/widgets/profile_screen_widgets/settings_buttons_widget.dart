import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class SettingsButtonsWidget extends StatelessWidget {
  const SettingsButtonsWidget({
    super.key,
    required this.function,
    required this.title,
  });
  final Function() function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        onTap: function,
        leading: CustomTextWidget(
          name: title,
          size: 18,
          fontWeight: FontWeight.bold,
          textColor: kWhiteColor,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 24,
          color: kWhiteColor.withOpacity(0.7),
        ),
      ),
    );
  }
}
