import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/widgets/user_list_tile.dart';
import 'package:social_flow/provider/bottom_nav_notifer.dart';
import 'package:social_flow/provider/search_notifier.dart';
import 'package:social_flow/services/auth_services.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, notifier, _) {
      if (notifier.searchedUsers.isEmpty) {
        return Center(
          child: Text(
            'No user founded',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).brightness == Brightness.light
                      ? CustomColors.lightModeDescriptionColor
                      : CustomColors.darkModeDescriptionColor,
                ),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemBuilder: (context, index) {
          UserModel user = notifier.searchedUsers[index];
          return Consumer<BottomNavNotifier>(builder: (context, bottomNavNotifier, _) {
            return InkWell(
                onTap: () {
                  bool isCurrentUser = AuthServices().isCurrentUser(uid: user.uid);
                  if (!isCurrentUser) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    );
                  } else {
                    bottomNavNotifier.onPageChanged(3);
                  }
                },
                child: UserListTile(user: user, isFollowScreens: false));
          });
        },
        separatorBuilder: (context, index) => CustomSize.height25,
        itemCount: notifier.searchedUsers.length,
      );
    });
  }
}
