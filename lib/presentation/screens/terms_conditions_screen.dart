import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/logo.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
These terms and conditions outline the rules and regulations for the use of Social Flow's App, located at Playstore.""",
                ),
                const Text(
                  """

govern your use of the Social Flow application ('App'). By using the App, you agree to comply with and be bound by this Agreement, as well as all applicable laws and regulations.""",
                ),
                Text(
                  """\n1. User Eligibility!""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
You must be 13 years or older to use the App. By using the App, you represent that you are at least 13 years of age.""",
                ),
                Text(
                  """\n2. User Accounts""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
You are responsible for maintaining the confidentiality of your Social Flow account login information. You are responsible for all activities that occur under your account, and you agree to notify Social Flow immediately of any unauthorized use of your account.""",
                ),
                Text(
                  """\n3. User Content""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
You are solely responsible for the content that you post on the App. You agree not to post content that is unlawful, defamatory, harassing, or otherwise objectionable. You also agree not to post content that infringes on the intellectual property rights of any third party.""",
                ),
                Text(
                  """\n4. User Conduct""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
You agree to use the App only for lawful purposes and in a manner that does not interfere with the use and enjoyment of the App by other users. You agree not to engage in any activity that could damage, disable, or impair the App, its servers, or its networks.""",
                ),
                Text(
                  """\n5. Intellectual Property""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
All content on the App, including but not limited to text, graphics, logos, button icons, images, audio clips, and software, is the property of Social Flow or its licensors and is protected by United States and international copyright laws.""",
                ),
                Text(
                  """\n6. Termination""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
Social Flow reserves the right to terminate your access to the App at any time, for any reason or no reason, without notice.""",
                ),
                Text(
                  """\n7. Disclaimer of Warranties""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
The App is provided 'as is' and Social Flow makes no warranties, express or implied, regarding the App, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement.""",
                ),
                Text(
                  """\n8. Limitation of Liability""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
In no event shall Social Flow be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the App, even if Social Flow has been advised of the possibility of such damages.""",
                ),
                Text(
                  """\n9. Governing Law""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
This Agreement shall be governed by and construed in accordance with the laws of the State of California.""",
                ),
                Text(
                  """\n10. Changes to this Agreement""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
Social Flow reserves the right to change this Agreement at any time. Your continued use of the App after any such changes constitutes your acceptance of the new Agreement.""",
                ),
                Text(
                  """\n11. Entire Agreement""",
                  style: customTextStyle(kMainColor, 16, FontWeight.bold),
                ),
                const Text(
                  """
This Agreement constitutes the entire agreement between you and Social Flow with respect to the App and supersedes all prior or contemporaneous communications and proposals, whether oral or written, between you and Social Flow.""",
                ),
                const Text(
                  """

If you have any questions about this Agreement, please contact us at support @swafvansafu07@gmail.com.""",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
