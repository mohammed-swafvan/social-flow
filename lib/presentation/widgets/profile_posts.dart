import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/post_screen.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ProfilePost extends StatelessWidget {
  const ProfilePost({super.key, required this.isCurrentUser});
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(builder: (context, notifier, _) {
      return StreamBuilder(
          stream: notifier.postStream,
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || notifier.postStream == null) {
              return const Center(
                child: GradientCircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Posts',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).brightness == Brightness.light
                            ? CustomColors.lightModeDescriptionColor
                            : CustomColors.darkModeDescriptionColor,
                      ),
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(postId: data['postId']),
                      ),
                    );
                  },
                  onLongPress: () async {
                    if (isCurrentUser) {
                      await notifier.deletePost(context: context, postId: data['postId']);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: CachedNetworkImage(
                      imageUrl: data['postUrl'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Utils().profilePostShimmer(),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          });
    });
  }
}
