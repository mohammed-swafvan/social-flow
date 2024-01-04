import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/post_screen.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/search_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, notifier, _) {
      return RefreshIndicator.adaptive(
        onRefresh: () async {
          notifier.getPostStream();
        },
        child: StreamBuilder(
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

              return MasonryGridView.count(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemCount: snapshot.data!.docs.length,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data();
                  double imageHeight = 150;
                  if (index % 5 == 0 || index % 4 == 0) {
                    imageHeight = 250;
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(postId: data['postId']),
                        ),
                      );
                    },
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: data['postUrl'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Utils().searchIdleShimmer(imageHeight: imageHeight),
                        ),
                      ),
                    ),
                  );
                },
                crossAxisCount: 2,
              );
            }),
      );
    });
  }
}
