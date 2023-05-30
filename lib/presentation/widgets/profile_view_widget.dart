import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';

class ProfileViewWidget extends StatelessWidget {
  const ProfileViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Consumer<ProfileScreenProvider>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(value.userData['photoUrl']),
                  ),
                  customStatColumn("${value.postLength}", "Post"),
                  customStatColumn("0", "Followers"),
                  customStatColumn("0", "Following"),
                ],
              );
            },
          ),
        ),
        Consumer<ProfileScreenProvider>(
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value.userData['username'],
                      style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                    ),
                    value.userData['bio'] == ""
                        ? TextSpan(
                            text: '\n${value.userData['email']}',
                            style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                          )
                        : TextSpan(
                            text: '\n${value.userData['email']} \n${value.userData['bio']}',
                            style: customTextStyle(kWhiteColor.withOpacity(0.8), 14, FontWeight.w400),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
