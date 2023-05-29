import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/single_post_screen.dart';

class PostTabBarViewWidget extends StatelessWidget {
  const PostTabBarViewWidget({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid).get(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            DocumentSnapshot snap = snapShot.data!.docs[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SinglePostScreen(
                      snap: snap.data(),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(snap['postUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: snapShot.data!.docs.length,
        );
      },
    );
  }
}
