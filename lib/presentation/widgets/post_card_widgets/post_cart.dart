import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/full_card.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/post_card_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.snap, required this.isHomepage, required this.isSinglePostScreen});
  final Map<String, dynamic> snap;
  final bool isHomepage;
  final bool isSinglePostScreen;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight;
    if (isHomepage) {
      imageHeight = screenHeight * 0.47;
    } else {
      imageHeight = screenHeight * 0.55;
    }
    return isSinglePostScreen
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kWhiteColor.withOpacity(0.7),
                ),
              ),
              title: CustomTextWidget(
                name: "Post",
                size: 24,
                fontWeight: FontWeight.bold,
                textColor: kYellowColor,
              ),
            ),
            body: Consumer<PostCardProvider>(
              builder: (context, value, _) {
                return FullCard(
                  snap: snap,
                  isHomepage: isHomepage,
                  user: user,
                  imageHeight: imageHeight,
                  screenHeight: screenHeight,
                );
              },
            ),
          )
        : FullCard(
            snap: snap,
            isHomepage: isHomepage,
            user: user,
            imageHeight: imageHeight,
            screenHeight: screenHeight,
          );
  }
}

