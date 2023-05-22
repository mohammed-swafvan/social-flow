import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';

class ProfileViewWidget extends StatelessWidget {
  const ProfileViewWidget({super.key, required this.userDetails, required this.postLength});

  final userDetails;
  final int postLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(userDetails['photoUrl']),
              ),
              customStatColumn("$postLength", "Post"),
              customStatColumn("0", "Followers"),
              customStatColumn("0", "Following"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: userDetails['username'],
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '\n${userDetails['email']} \n${userDetails['bio']}',
              style: TextStyle(color: kWhiteColor.withOpacity(0.8), fontWeight: FontWeight.w400),
            ),
          ])),
        )
      ],
    );
  }
}
