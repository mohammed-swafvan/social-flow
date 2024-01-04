import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/theme/custom_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  "Privacy & Policy",
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
                        """1. Information We Collect""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """1.1 Personal Information :""",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        """
When Users register on the App, we may collect personal identification information such as name, email address, and profile picture.
Users may choose to provide additional information voluntarily, such as a biography, location, or website link.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n1.2 Non-Personal Information :""",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        """We may collect non-personal identification information about Users whenever they interact with the App. This information may include the device name, operating system, browser type, and IP address.
""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """2. How We Use Collected Information""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """2.1 Personal Information :""",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Text(
                        """We may use the personal information provided by Users for the following purposes:
To personalize User experience: We may use information to personalize the User's profile and tailor content to their interests.
To improve customer service: Information provided helps us respond to customer service requests effectively.
To send periodic emails: We may use the provided email address to send User updates, notifications, and important information.""",
                      ),
                      Text(
                        """\n2.2 Non-Personal Information :""",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        """We may collect non-personal information for statistical analysis, troubleshooting, and enhancing the App's functionality and security.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n3. How We Protect Your Information""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """
We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information, username, password, transaction information, and data stored on our App.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n4. Sharing Your Personal Information""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """
We do not sell, trade, or rent User's personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding Users with our business partners, trusted affiliates, and advertisers for the purposes outlined above.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n5. Third-Party Websites""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """
Users may find advertising or other content on the App that links to the sites and services of our partners, suppliers, advertisers, sponsors, licensors, and other third parties. We do not control the content or links that appear on these sites and are not responsible for the practices employed by websites linked to or from the App.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n6. Changes to This Privacy Policy""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """
SocialFlow has the discretion to update this Privacy Policy at any time. We encourage Users to frequently check this page for any changes and to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this Privacy Policy periodically and become aware of modifications.""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\n7. Your Acceptance of These Terms""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """
By using this App, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our App. Your continued use of the App following the posting of changes to this policy will be deemed your acceptance of those changes""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """\nContact Us""",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        """If you have any questions about this Privacy Policy, You can contact us :""",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        """By email: swafvansafu07@gmail.com""",
                        style: Theme.of(context).textTheme.labelMedium,
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
