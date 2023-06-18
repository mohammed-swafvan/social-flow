import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/logo.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          name: "Terms & Conditions",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Stack(
        children: [
          const Center(
            child: SocilaFlowLogo(radius: 120),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: ListView(
              children: [
                Text(
                  """Welcome to Social Flow!""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
We are dedicated to providing you the very best social media varient, with an emphasis on new features.user login, user signup, chat, search, follow, unfollow, add post, save post, like post, and comment, and a rich user experience.""",
                ),
                const Text(
                  """

Founded in 2023 by Mohammed Swafvan PP. Social Flow app is our second major project with a basic performance of social hub and creates a better versions in future. Social Flow gives you the best social media experience that you never had. it includes attractive mode of UI's and good practices.""",
                ),
                const Text(
                  """

Social Flow gives good quality and had increased the settings to power up the system as well as to provide better social media experience.""",
                ),
                const Text(
                  """

We hope you enjoy our social flow app as much as we enjoy offering them to you. if you have any questions or comments, please don't hesitate to contact us.""",
                ),
                const Text(
                  """

Sincerely,
Mohammed Swafvan pp
""",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
