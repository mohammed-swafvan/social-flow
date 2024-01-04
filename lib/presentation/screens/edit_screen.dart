import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/utils/gradient_container.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/auth_button.dart';
import 'package:social_flow/presentation/widgets/auth_text_field_box.dart';
import 'package:social_flow/provider/edit_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/provider/user_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    updateUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, _) {
          return profileNotifier.isLoading
              ? const Center(
                  child: GradientCircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    height: screenHeight,
                    child: Stack(
                      children: [
                        const GradientContainer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Column(
                            children: [
                              FadeInDown(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Edit Profile",
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    Text(
                                      "You can edit your profile now!",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white.withOpacity(0.6),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomSize.height15,
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: FadeInUp(
                                    child: Material(
                                      elevation: 6.0,
                                      shadowColor:
                                          Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? Colors.white
                                              : Colors.grey.shade900,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Consumer<EditNotifier>(builder: (context, notifier, _) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: InkWell(
                                                  onTap: () async {
                                                    await notifier.updataProfilePhoto(context: context);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                        width: 90,
                                                        height: 90,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(90),
                                                          child: notifier.file == null
                                                              ? CachedNetworkImage(
                                                                  imageUrl: profileNotifier.userData['photoUrl'],
                                                                  fit: BoxFit.cover,
                                                                  placeholder: (context, url) =>
                                                                      Utils().roundedPhotoShimmer(radius: 90),
                                                                )
                                                              : Image.memory(
                                                                  notifier.file!,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                          padding: const EdgeInsets.all(3),
                                                          decoration: BoxDecoration(
                                                            color: CustomColors.scaffoldBackgroundColor,
                                                            border: Border.all(
                                                              width: 3,
                                                              color: Theme.of(context).brightness == Brightness.light
                                                                  ? Colors.white
                                                                  : Colors.grey.shade900,
                                                            ),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: CustomColors.socialFlowLabelColor,
                                                            size: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              CustomSize.height25,
                                              Text(
                                                ' User Name',
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              AuthTextFieldBox(
                                                isAuthentication: false,
                                                hintText: profileNotifier.userData['username'],
                                                controller: notifier.usernameController,
                                              ),
                                              CustomSize.height20,
                                              Text(
                                                ' Name',
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              AuthTextFieldBox(
                                                isAuthentication: false,
                                                hintText: profileNotifier.userData['name'].isEmpty
                                                    ? "Add Name"
                                                    : profileNotifier.userData['name'],
                                                controller: notifier.nameController,
                                              ),
                                              CustomSize.height20,
                                              Text(
                                                ' Category',
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              AuthTextFieldBox(
                                                isAuthentication: false,
                                                hintText: profileNotifier.userData['category'].isEmpty
                                                    ? "Add category"
                                                    : profileNotifier.userData['category'],
                                                controller: notifier.categoryController,
                                              ),
                                              CustomSize.height20,
                                              Text(
                                                ' Bio',
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              AuthTextFieldBox(
                                                isAuthentication: false,
                                                hintText: profileNotifier.userData['bio'].isEmpty
                                                    ? "Add bio"
                                                    : profileNotifier.userData['bio'],
                                                controller: notifier.bioController,
                                              ),
                                              CustomSize.height30,
                                              InkWell(
                                                onTap: () async {
                                                  String username = notifier.usernameController.text.isEmpty
                                                      ? profileNotifier.userData['username']
                                                      : notifier.usernameController.text;
                                                  String name = notifier.nameController.text.isEmpty
                                                      ? profileNotifier.userData['name']
                                                      : notifier.nameController.text;
                                                  String category = notifier.categoryController.text.isEmpty
                                                      ? profileNotifier.userData['category']
                                                      : notifier.categoryController.text;
                                                  String bio = notifier.bioController.text.isEmpty
                                                      ? profileNotifier.userData['bio']
                                                      : notifier.bioController.text;
                                                  await notifier.updateUserData(
                                                    context: context,
                                                    photoUrl: profileNotifier.userData['photoUrl'],
                                                    username: username,
                                                    name: name,
                                                    category: category,
                                                    bio: bio,
                                                  );
                                                  if (context.mounted) {
                                                    await Provider.of<UserNotifier>(context, listen: false).refreshUser();
                                                  }
                                                  notifier.despostControllers();
                                                  updateUserData();
                                                },
                                                child: const AuthButton(text: "Edit"),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 22,
                          right: 16,
                          child: Consumer<EditNotifier>(builder: (context, notifier, _) {
                            return InkWell(
                              onTap: () {
                                notifier.despostControllers();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                                      : CustomColors.darkModeDescriptionColor.withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: CustomColors.socialFlowLabelColor,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future<void> updateUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    ProfileNotifier notifier = Provider.of<ProfileNotifier>(context, listen: false);
    await notifier.getData(context: context, uid: auth.currentUser!.uid);
  }
}
