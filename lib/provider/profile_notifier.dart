import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/firestore_services.dart';

class ProfileNotifier extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? postStream;
  Stream<QuerySnapshot<Map<String, dynamic>>>? savedPostStream;
  Map<String, dynamic> userData = {};
  int postLength = 0;
  bool isLoading = false;
  int savedPostLength = 0;

  getUserPost({required String uid}) async {
    postStream = FirestoreServices().getUserPostStream(uid: uid);
    notifyListeners();
  }

  getUserSavedPost({required String uid}) async {
    savedPostStream = FirestoreServices().getSavedPostStream(uid: uid);
    notifyListeners();
  }

  Future getData({required BuildContext context, required String uid}) async {
    isLoading = true;
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = userSnap.data()!;
      var postSnap = await FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid).get();
      var savePostSnap = await FirebaseFirestore.instance.collection('users').doc(uid).collection('saved_posts').get();
      savedPostLength = savePostSnap.docs.length;
      postLength = postSnap.docs.length;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        Utils().customSnackBar(context: context, content: e.toString());
      }
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> updataProfilePhoto({required BuildContext context}) async {
    await Utils().showAddProfileBottomSheet(context: context);
    notifyListeners();
  }

  Future<void> deletePost({required BuildContext context, required String postId}) async {
    Utils().showDeletePostBottomSheet(
        context: context,
        onTap: () {
          Navigator.pop(context);
          Utils().showDialogBox(
            context: context,
            onTap: () async {
              Navigator.pop(context);
              await FirestoreServices().deletePost(postId: postId);
              if (context.mounted) {
                Utils().customSnackBar(context: context, content: "Post is deleted successfully");
              }
            },
            title: "Delete!",
            content: "Are you sure, you want to delete the post?",
          );
        });
  }

  set loading(bool value) {
    isLoading = value;
  }
}
