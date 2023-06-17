import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({
    super.key,
    this.function,
    required this.bgColor,
    required this.text,
  });

  final Function()? function;
  final Color bgColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: function,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 2, top: 4),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: kWhiteColor.withOpacity(0.7),
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomTextWidget(
            name: text,
            size: 16,
            fontWeight: FontWeight.w500,
            textColor: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
