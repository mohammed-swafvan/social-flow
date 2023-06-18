import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/logo.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

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
          name: "Privacy & Policy",
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
                  """1. Information We Collect""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                Text(
                  """1.1 Personal Information :""",
                  style: customTextStyle(kWhiteColor, 15, FontWeight.bold),
                ),
                const Text(
                  """
When Users register on the App, we may collect personal identification information such as name, email address, and profile picture.
Users may choose to provide additional information voluntarily, such as a biography, location, or website link.""",
                ),
                Text(
                  """\n1.2 Non-Personal Information :""",
                  style: customTextStyle(kWhiteColor, 15, FontWeight.bold),
                ),
                const Text(
                  """We may collect non-personal identification information about Users whenever they interact with the App. This information may include the device name, operating system, browser type, and IP address.
""",
                ),
                Text(
                  """2. How We Use Collected Information""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                Text(
                  """2.1 Personal Information :""",
                  style: customTextStyle(kWhiteColor, 15, FontWeight.bold),
                ),
                const Text(
                  """We may use the personal information provided by Users for the following purposes:
To personalize User experience: We may use information to personalize the User's profile and tailor content to their interests.
To improve customer service: Information provided helps us respond to customer service requests effectively.
To send periodic emails: We may use the provided email address to send User updates, notifications, and important information.""",
                ),
                Text(
                  """\n2.2 Non-Personal Information :""",
                  style: customTextStyle(
                    kWhiteColor,
                    15,
                    FontWeight.bold,
                  ),
                ),
                const Text(
                  """We may collect non-personal information for statistical analysis, troubleshooting, and enhancing the App's functionality and security.""",
                ),
                Text(
                  """\n3. How We Protect Your Information""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information, username, password, transaction information, and data stored on our App.""",
                ),
                Text(
                  """\n4. Sharing Your Personal Information""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
We do not sell, trade, or rent User's personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding Users with our business partners, trusted affiliates, and advertisers for the purposes outlined above.""",
                ),
                Text(
                  """\n5. Third-Party Websites""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
Users may find advertising or other content on the App that links to the sites and services of our partners, suppliers, advertisers, sponsors, licensors, and other third parties. We do not control the content or links that appear on these sites and are not responsible for the practices employed by websites linked to or from the App.""",
                ),
                Text(
                  """\n6. Changes to This Privacy Policy""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
SocialFlow has the discretion to update this Privacy Policy at any time. We encourage Users to frequently check this page for any changes and to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this Privacy Policy periodically and become aware of modifications.""",
                ),
                Text(
                  """\n7. Your Acceptance of These Terms""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
By using this App, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our App. Your continued use of the App following the posting of changes to this policy will be deemed your acceptance of those changes""",
                ),
                Text(
                  """\nContact Us""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """If you have any questions about this Privacy Policy, You can contact us :""",
                ),
                const Text(
                  """By email: swafvansafu07@gmail.com""",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
