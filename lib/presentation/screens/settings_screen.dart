// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/about_us_screen.dart';
import 'package:social_flow/presentation/screens/account_details_screen.dart';
import 'package:social_flow/presentation/screens/edit_screen.dart';
import 'package:social_flow/presentation/screens/privacy_policy_screen.dart';
import 'package:social_flow/presentation/screens/terms_conditions_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/presentation/widgets/profile_screen_widgets/settings_buttons_widget.dart';
import 'package:social_flow/providers/user_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: "Settings",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Column(
        children: [
          SettingsButtonsWidget(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountDetailsScreen(),
                ),
              );
            },
            title: 'Account Details',
          ),
          SettingsButtonsWidget(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditScreen(),
                ),
              );
            },
            title: 'Edit Profile',
          ),
          SettingsButtonsWidget(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyAndPolicyScreen(),
                ),
              );
            },
            title: 'Privacy & Policy',
          ),
          SettingsButtonsWidget(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditionsScreen(),
                ),
              );
            },
            title: 'Terms & Conditions',
          ),
          SettingsButtonsWidget(
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
            title: 'About Us',
          ),
          kHeight10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                await showMyAlertDialog(context, user.username);
              },
              child: SizedBox(
                width: double.infinity,
                child: CustomTextWidget(
                  name: 'Log Out ${user!.username}',
                  size: 16,
                  fontWeight: FontWeight.w500,
                  textColor: kRedColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomTextWidget(
                name: 'Version 1.0',
                size: 14,
                fontWeight: FontWeight.w500,
                textColor: kYellowColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  
}
