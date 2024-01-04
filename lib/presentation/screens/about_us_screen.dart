import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/theme/custom_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6).copyWith(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.light
                          ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                          : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: CustomColors.socialFlowLabelColor,
                    ),
                  ),
                ),
                CustomSize.width10,
                Text(
                  "About Us",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.socialFlowLabelColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              width: screenWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).brightness == Brightness.light
                        ? CustomColors.lightModeDescriptionColor.withOpacity(0.1)
                        : CustomColors.darkModeDescriptionColor.withOpacity(0.1),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        """Welcome to Social Flow!""",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                            ),
                      ),
                      Text(
                        """

We are dedicated to providing you the very best social media varient, with an emphasis on new features.user login, user signup, chat, search, follow, unfollow, add post, save post, like post, and comment, and a rich user experience.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

Founded in 2023 by Mohammed Swafvan PP. Social Flow app is our second major project with a basic performance of social hub and creates a better versions in future. Social Flow gives you the best social media experience that you never had. it includes attractive mode of UI's and good practices.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

Social Flow gives good quality and had increased the settings to power up the system as well as to provide better social media experience.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

We hope you enjoy our social flow app as much as we enjoy offering them to you. if you have any questions or comments, please don't hesitate to contact us.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

Sincerely,
Mohammed Swafvan pp
""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
