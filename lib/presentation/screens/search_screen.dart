import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/search_idle.dart';
import 'package:social_flow/presentation/widgets/search_result.dart';
import 'package:social_flow/presentation/widgets/search_text_field.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/search_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeData(context: context);
    });
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SearchTextField(),
                CustomSize.width10,
                Consumer<SearchNotifier>(
                  builder: (context, notifier, _) {
                    return Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: CustomColors.iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          notifier.hideUsers = true;
                          notifier.searchController.clear();
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: CustomColors.socialFlowLabelColor,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ],
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
              child: Consumer<SearchNotifier>(
                builder: (context, notifer, _) {
                  if (notifer.isLoading) {
                    return const Center(
                      child: GradientCircularProgressIndicator(),
                    );
                  }
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: notifer.hideUser ? const SearchIdle() : const SearchResult(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initializeData({required BuildContext context}) async {
    SearchNotifier notifier = Provider.of<SearchNotifier>(context, listen: false);
    FollowAndFollowingNotifier followFollowingNotifier = Provider.of<FollowAndFollowingNotifier>(context, listen: false);
    await notifier.getPostStream();
    await followFollowingNotifier.getUserStream();
    await notifier.getAllUsers();
  }
}
