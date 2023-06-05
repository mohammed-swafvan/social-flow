import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/utils.dart';

class ProfileScreenProvider extends ChangeNotifier {
  String? uid;
  var userData = {};
  int postLength = 0;
  bool isLoading = false;
  bool isFollowing = false;

  getData(BuildContext context, uid) async {
    isLoading = true;
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = userSnap.data()!;

      var postSnap = await FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid).get();
      postLength = postSnap.docs.length;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      showSnackbar(e.toString(), context);
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }
}
