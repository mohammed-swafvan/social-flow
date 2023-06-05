import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
            child: const Text('No Posts'),
          );
        }

        return MasonryGridView.count(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          controller: ScrollController(keepScrollOffset: false),
          itemCount: snapshot.data!.docs.length,
          mainAxisSpacing: 5,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            final snap = snapshot.data!.docs[index];
            return Container(
              height: index % 5 == 0 || index % 4 == 0 ? 250 : 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(snap['postUrl']),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          crossAxisCount: 2,
        );
      },
    );
  }
}
