
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/comment_length.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/description_section.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/header_section.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/image_section.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/like_comment_section.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/user_provider.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.snap,

  });

  final Map<String, dynamic> snap;
 

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    final screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight;
   
      imageHeight = screenHeight * 0.47;
    return user != null
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////// Header section ////////
                HeaderSectionWidget(
                  snap: snap,
                ),
                const SizedBox(height: 5),

                /////// Image section //////
                ImageSectionWidget(
                  snap: snap,
                  user: user,
                  imageHeight: imageHeight,
                ),

                //////// Like Comment and save section /////////
                LikeCommentSection(
                  snap: snap,
                  user: user,
                ),

                //////// desribtion and number of like section ///////
                DescriptionSectionWidget(
                  snap: snap,
                ),

                //// comment length /////
                CommentLengthWidget(
                  snap: snap,
                ),

                //// date ////
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomTextWidget(
                    name: DateFormat.yMEd().format(snap['datePublished'].toDate()),
                    size: 12,
                    fontWeight: FontWeight.w200,
                    textColor: kWhiteColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            height: screenHeight * 0.9,
            child: const Center(
              child: CircularProgressWidget(),
            ),
          );
  }
}
