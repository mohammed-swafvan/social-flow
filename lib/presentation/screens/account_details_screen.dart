import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/widgets/account_deatails_card_widget.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).getUser;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: "Account Details",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: screenWidth,
        child: ListView(
          children: [
            kHeight20,
            Column(
              children: [
                Container(
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: NetworkImage(user!.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            kHeight30,
            AcoountDetailsCardWidget(
              field: 'Username',
              value: user.username,
            ),
            kHeight15,
            AcoountDetailsCardWidget(
              field: 'Following',
              value: user.following.length.toString(),
            ),
            kHeight15,
            AcoountDetailsCardWidget(
              field: 'Followers',
              value: user.followers.length.toString(),
            ),
            kHeight15,
            Consumer<ProfileScreenProvider>(
              builder: (context, value, _) {
                return AcoountDetailsCardWidget(
                  field: 'Posts',
                  value: value.postLength.toString(),
                );
              },
            ),
            kHeight15,
            Consumer<ProfileScreenProvider>(
              builder: (context, value, _) {
                return AcoountDetailsCardWidget(
                  field: 'Saved post',
                  value: value.savedPostLength.toString(),
                );
              },
            ),
            kHeight15,
            AcoountDetailsCardWidget(
              field: 'Category',
              value: user.category.isNotEmpty ? user.category : 'No category',
              textColor: user.category.isNotEmpty ? kWhiteColor : kWhiteColor.withOpacity(0.7),
            ),
            kHeight15,
            AcoountDetailsCardWidget(
              field: 'Bio',
              value: user.bio.isNotEmpty ? user.bio : 'No bio',
              textColor: user.bio.isNotEmpty ? kWhiteColor : kWhiteColor.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
