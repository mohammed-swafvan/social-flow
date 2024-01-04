import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/about_us_screen.dart';
import 'package:social_flow/presentation/screens/edit_screen.dart';
import 'package:social_flow/presentation/screens/privacy_policy_screen.dart';
import 'package:social_flow/presentation/screens/terms_and_conditions.dart';
import 'package:social_flow/presentation/screens/user_info_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/provider/menu_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> items = ["User Information", "Edit", "Privacy Policy", "Terms & Conditions", "About Us"];
    final List<Widget> screens = [
      const UserInfoScreen(),
      const EditScreen(),
      const PrivacyPolicyScreen(),
      const TermsAndConditionScreen(),
      const AboutUsScreen(),
    ];
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
                  "Menu",
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screens[index],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.1)
                                  : CustomColors.darkModeDescriptionColor.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index],
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? CustomColors.lightModeDescriptionColor
                                      : CustomColors.darkModeDescriptionColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => CustomSize.height15,
                      itemCount: items.length,
                    ),
                    CustomSize.height20,
                    Consumer<MenuNotifier>(builder: (context, notifier, _) {
                      return Row(
                        children: [
                          Consumer<ProfileNotifier>(builder: (context, profileNotifier, _) {
                            return InkWell(
                              onTap: () async {
                                notifier.logOutUser(context: context, username: profileNotifier.userData['username']);
                              },
                              child: Text(
                                "  Log Out ${profileNotifier.userData['username']}",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                              ),
                            );
                          }),
                          CustomSize.width10,
                          Visibility(
                            visible: notifier.isLoading,
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Theme.of(context).brightness == Brightness.light
                                    ? CustomColors.lightModeDescriptionColor
                                    : CustomColors.darkModeDescriptionColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "version 2.0",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.scaffoldBackgroundColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
