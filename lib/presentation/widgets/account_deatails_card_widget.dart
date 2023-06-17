import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class AcoountDetailsCardWidget extends StatelessWidget {
  const AcoountDetailsCardWidget({
    super.key,
    required this.field,
    required this.value,
    this.textColor = Colors.white,
  });

  final String field;
  final String value;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          color: kWhiteColor.withOpacity(0.08),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: kMainColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            name: '$field : ',
            size: 18,
            fontWeight: FontWeight.bold,
            textColor: kYellowColor,
          ),
          Expanded(
            child: CustomTextWidget(
              name: value,
              size: 18,
              fontWeight: FontWeight.w500,
              textColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
