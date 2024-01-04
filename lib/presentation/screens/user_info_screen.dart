import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/user_info_card.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

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
                  "User Info",
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                child: Consumer<ProfileNotifier>(
                  builder: (context, profileNotifier, _) {
                    return profileNotifier.isLoading
                        ? const Center(
                            child: GradientCircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: profileNotifier.userData['photoUrl'],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Utils().containerShimmer(
                                              width: 120,
                                              height: 120,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          )),
                                    ),
                                    CustomSize.width10,
                                    Expanded(
                                      child: Text(
                                        "The profile showcases key details including profile pic, username, and other, complemented by your post count.This interface enhancing the user's digital footprint on the platform.",
                                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                              color: Theme.of(context).brightness == Brightness.light
                                                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.6)
                                                  : CustomColors.darkModeDescriptionColor.withOpacity(0.6),
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CustomSize.height30,
                              UserInfoCard(
                                labelText: "User Name",
                                text: profileNotifier.userData['username'],
                                valueIsEmpty: false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Name",
                                text: profileNotifier.userData['name'].isEmpty ? "No name" : profileNotifier.userData['name'],
                                valueIsEmpty: profileNotifier.userData['name'].isEmpty ? true : false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Posts",
                                text: profileNotifier.postLength == 0 ? "0" : "${profileNotifier.postLength}",
                                valueIsEmpty: profileNotifier.postLength == 0 ? true : false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Category",
                                text: profileNotifier.userData['category'].isEmpty
                                    ? "No category"
                                    : profileNotifier.userData['category'],
                                valueIsEmpty: profileNotifier.userData['category'].isEmpty ? true : false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Bio",
                                text: profileNotifier.userData['bio'].isEmpty ? "No Bio" : profileNotifier.userData['bio'],
                                valueIsEmpty: profileNotifier.userData['bio'].isEmpty ? true : false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Followers",
                                text: profileNotifier.userData['followers'].isEmpty
                                    ? "0"
                                    : "${profileNotifier.userData['followers'].length}",
                                valueIsEmpty: profileNotifier.userData['followers'].isEmpty ? true : false,
                              ),
                              CustomSize.height15,
                              UserInfoCard(
                                labelText: "Following",
                                text: profileNotifier.userData['following'].isEmpty
                                    ? "0"
                                    : "${profileNotifier.userData['following'].length}",
                                valueIsEmpty: profileNotifier.userData['following'].isEmpty ? true : false,
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCurrentUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    ProfileNotifier notifier = Provider.of<ProfileNotifier>(context, listen: false);
    await notifier.getData(context: context, uid: auth.currentUser!.uid);
    await notifier.getUserPost(uid: auth.currentUser!.uid);
    await notifier.getUserSavedPost(uid: auth.currentUser!.uid);
  }
}
