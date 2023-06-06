import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/search_screen_provider.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<SearchScreenProvider>(
      builder: (context, value, _) {
        final searchQuery = value.searchController.text.trim();
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where(
                'username',
                isGreaterThanOrEqualTo: searchQuery,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: double.infinity,
                height: screenHeight * 0.8,
                child: const Center(child: CircularProgressWidget()),
              );
            }

            if (!snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: screenHeight * 0.8,
                child: Center(
                  child: CustomTextWidget(
                    name: 'No user founded',
                    size: 16,
                    fontWeight: FontWeight.w500,
                    textColor: kWhiteColor,
                  ),
                ),
              );
            }

            return snapshot.data!.docs.isEmpty
                ? SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.8,
                    child: Center(
                      child: CustomTextWidget(
                        name: 'No user founded',
                        size: 16,
                        fontWeight: FontWeight.w500,
                        textColor: kWhiteColor,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    controller: ScrollController(keepScrollOffset: false),
                    itemBuilder: (context, index) {
                      var snap = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ListTile(
                          minVerticalPadding: 20,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(snap['photoUrl']),
                          ),
                          title: CustomTextWidget(
                            name: snap['username'],
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
                    itemCount: snapshot.data!.docs.length,
                  );
          },
        );
      },
    );
  }
}
