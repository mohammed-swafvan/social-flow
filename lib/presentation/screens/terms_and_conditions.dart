import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/theme/custom_colors.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

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
                  "Terms & Conditions",
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
These terms and conditions outline the rules and regulations for the use of Social Flow's App, located at Playstore.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

govern your use of the Social Flow application ('App'). By using the App, you agree to comply with and be bound by this Agreement, as well as all applicable laws and regulations.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n1. User Eligibility!""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
You must be 18 years or older to use the App. By using the App, you represent that you are at least 18 years of age.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n2. User Accounts""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
You are responsible for maintaining the confidentiality of your Social Flow account login information. You are responsible for all activities that occur under your account, and you agree to notify Social Flow immediately of any unauthorized use of your account.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n3. User Content""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
You are solely responsible for the content that you post on the App. You agree not to post content that is unlawful, defamatory, harassing, or otherwise objectionable. You also agree not to post content that infringes on the intellectual property rights of any third party.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n4. User Conduct""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
You agree to use the App only for lawful purposes and in a manner that does not interfere with the use and enjoyment of the App by other users. You agree not to engage in any activity that could damage, disable, or impair the App, its servers, or its networks.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n5. Intellectual Property""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
All content on the App, including but not limited to text, graphics, logos, button icons, images, audio clips, and software, is the property of Social Flow or its licensors and is protected by United States and international copyright laws.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n6. Termination""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
Social Flow reserves the right to terminate your access to the App at any time, for any reason or no reason, without notice.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n7. Disclaimer of Warranties""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
The App is provided 'as is' and Social Flow makes no warranties, express or implied, regarding the App, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n8. Limitation of Liability""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
In no event shall Social Flow be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the App, even if Social Flow has been advised of the possibility of such damages.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n9. Governing Law""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
This Agreement shall be governed by and construed in accordance with the laws of the State of California.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n10. Changes to this Agreement""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
Social Flow reserves the right to change this Agreement at any time. Your continued use of the App after any such changes constitutes your acceptance of the new Agreement.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """\n11. Entire Agreement""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """
This Agreement constitutes the entire agreement between you and Social Flow with respect to the App and supersedes all prior or contemporaneous communications and proposals, whether oral or written, between you and Social Flow.""",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        """

If you have any questions about this Agreement, please contact us at support @swafvansafu07@gmail.com.""",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
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
