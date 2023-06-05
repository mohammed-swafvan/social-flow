import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class DescriptionSectionWidget extends StatelessWidget {
  const DescriptionSectionWidget({
    super.key,
    required this.snap,
  });

  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            name: "${snap['likes'].length} likes",
            size: 14,
            fontWeight: FontWeight.normal,
            textColor: kWhiteColor.withOpacity(0.9),
          ),
          SizedBox(
            width: double.infinity,
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(style: customTextStyle(kWhiteColor, 16, FontWeight.bold), children: [
                TextSpan(
                  text: snap['username'],
                ),
                TextSpan(
                  text: '  ${snap['description']}',
                  style: customTextStyle(kWhiteColor.withOpacity(0.9), 15, FontWeight.w500),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
