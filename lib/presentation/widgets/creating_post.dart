import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/create_post_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class CreatingPost extends StatelessWidget {
  const CreatingPost({super.key, required this.userDetails});
  final UserModel userDetails;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          height: screenHeight * 0.84,
          child: Consumer<CreatePostNotifier>(
            builder: (context, notifier, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(38),
                          child: CachedNetworkImage(
                            imageUrl: userDetails.photoUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 44),
                          ),
                        ),
                      ),
                      CustomSize.width10,
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: MemoryImage(notifier.file!),
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screenWidth * 0.8,
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "You can create a description for your post, So it will be helpful for others to understand you thought.",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? CustomColors.lightModeDescriptionColor
                                        : CustomColors.darkModeDescriptionColor,
                                  ),
                            ),
                          ),
                          CustomSize.height5,
                          Container(
                            width: screenWidth * 0.8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.2)
                                  : CustomColors.darkModeDescriptionColor.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                              child: TextField(
                                controller: notifier.decriptionController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? CustomColors.lightModeDescriptionColor
                                            : CustomColors.darkModeDescriptionColor,
                                      ),
                                  hintText: "Write a caption...",
                                  border: InputBorder.none,
                                ),
                                maxLines: 6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          notifier.imageFile = null;
                          notifier.decriptionController.clear();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: screenWidth / 2.2,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          notifier.uploadPost(
                            context: context,
                            postFile: notifier.file!,
                            username: userDetails.username,
                            profUrl: userDetails.photoUrl,
                            description: notifier.decriptionController.text,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: screenWidth / 2.2,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  CustomColors.firstGradientColor,
                                  CustomColors.secondGradientColor,
                                ],
                                begin: Alignment.topLeft,
                                end: AlignmentDirectional.bottomEnd,
                              ),
                              border: Border.all(
                                color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: notifier.isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Post",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
