import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/followers_provider.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key, required this.uid, required this.profileScreenUid});
  final String uid;
  final String profileScreenUid;

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FollowerScreenProvider>(context, listen: false).getUserFollowers(
      userUid: widget.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Provider.of<ProfileScreenProvider>(context, listen: false).uid = widget.profileScreenUid;
            Provider.of<ProfileScreenProvider>(context, listen: false).getData(context, widget.profileScreenUid);
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: 'Followers',
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Consumer<FollowerScreenProvider>(
        builder: (context, value, _) {
          return value.isLoading
              ? const Center(
                  child: CircularProgressWidget(),
                )
              : value.userModelList!.isEmpty
                  ? Center(
                      child: CustomTextWidget(
                        name: 'No followers',
                        size: 18,
                        fontWeight: FontWeight.w500,
                        textColor: kWhiteColor,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    uid: value.userModelList![index].uid,
                                    isCurrentUserProfile: false,
                                  ),
                                ),
                              );
                            },
                            minVerticalPadding: 20,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(value.userModelList![index].photoUrl),
                            ),
                            title: CustomTextWidget(
                              name: value.userModelList![index].username,
                              size: 18,
                              fontWeight: FontWeight.w500,
                              textColor: kWhiteColor,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: kWhiteColor.withOpacity(0.3),
                            thickness: 1,
                          ),
                        );
                      },
                      itemCount: value.userModelList!.length,
                    );
        },
      ),
    );
  }
}
