// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/utils.dart';

class ProfileScreenProvider extends ChangeNotifier {
  String? uid;
  var userData = {};
  int postLength = 0;
  bool isLoading = false;
  int savedPostLength = 0;

  Future getData(BuildContext context, uid) async {
    isLoading = true;
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = userSnap.data()!;
      var postSnap = await FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: uid).get();
      var savePostSnap = await FirebaseFirestore.instance.collection('users').doc(uid).collection('savedImages').get();
      savedPostLength = savePostSnap.docs.length;
      postLength = postSnap.docs.length;
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
