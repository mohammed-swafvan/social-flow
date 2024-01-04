import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_icons.dart';
import 'package:social_flow/presentation/utils/gradient_text.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/creating_post.dart';
import 'package:social_flow/provider/create_post_notifier.dart';
import 'package:social_flow/provider/user_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userDetails = Provider.of<UserNotifier>(context, listen: false).getUser;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create Post",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.socialFlowLabelColor,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Consumer<CreatePostNotifier>(builder: (context, notifier, _) {
                return notifier.file == null
                    ? Center(
                        child: InkWell(
                          onTap: () {
                            Utils().showAddPostBottomSheet(context: context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const GradientIcon(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 40,
                                ),
                              ),
                              CustomSize.height5,
                              GradientText(
                                text: "Create Post",
                                gradient: const LinearGradient(
                                  colors: [
                                    CustomColors.firstGradientColor,
                                    CustomColors.secondGradientColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : CreatingPost(userDetails: userDetails);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
