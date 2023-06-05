

import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListTile(
              minVerticalPadding: 20,
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/my_prof_pic.jpg'),
              ),
              title: CustomTextWidget(
                name: 'user name',
                size: 18,
                fontWeight: FontWeight.w500,
                textColor: kWhiteColor,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
          );
        },
        itemCount: 20,);
  }
}


