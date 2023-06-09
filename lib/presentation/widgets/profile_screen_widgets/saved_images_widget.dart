import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/single_post_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';

class SavedImagesWidget extends StatelessWidget {
  const SavedImagesWidget({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenProvider>(
      builder: (context, value, _) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('savedImages')
              .where('currentUserUid', isEqualTo: value.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapShot.data!.docs.isEmpty
                ? Center(
                    child: CustomTextWidget(
                      name: "No Saved Posts",
                      size: 18,
                      fontWeight: FontWeight.w500,
                      textColor: kWhiteColor,
                    ),
                  )
                : GridView.builder(
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
                                snap: snapShot.data!.docs[index].data(),
                                title: 'Saved',
                                isSavePostScreen: true,
                                uid: uid,
                              ),
                            ),
                          );
                        },
                        onLongPress: () async {},
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
      },
    );
  }
}
