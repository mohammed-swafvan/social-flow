import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/utils.dart';

class ProfileScreenProvider extends ChangeNotifier {
  var userData = {};
  int postLength = 0;
  bool isLoading = false;

  getData(String uid, BuildContext context) async {
    isLoading = true;

    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = userSnap.data()!;

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;
      isLoading = false;
    } catch (e) {
      showSnackbar(e.toString(), context);
      isLoading = false;
    }
    notifyListeners();
  }
}
