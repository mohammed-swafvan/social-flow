import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/user_provider.dart';

class HeaderSectionWidget extends StatelessWidget {
  const HeaderSectionWidget({
    super.key,
    required this.snap,
  });

  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = Provider.of<UserProvider>(context, listen: false).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              snap['profImage'],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      uid: snap['uid'],
                      isCurrentUserProfile: false,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      name: snap['username'],
                      size: 18,
                      fontWeight: FontWeight.w400,
                      textColor: kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          snap['uid'] == currentUser!.uid
              ? IconButton(
                  onPressed: () async {
                    await deleteDialogue(snap: snap, ctx: context,isSinglePostScreen: false ,isPost: true);
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: kWhiteColor.withOpacity(0.8),
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    await otherUsersMoreDialogue(snap, context, false);
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: kWhiteColor.withOpacity(0.8),
                    size: 30,
                  ),
                ),
        ],
      ),
    );
  }
}
