import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCardProvider extends ChangeNotifier {
  bool isLikeAnimating = false;
  int commentLength = 0;

  likeAnimationTrue() {
    isLikeAnimating = true;
    notifyListeners();
  }

  likeAnimationFalse() {
    isLikeAnimating = false;
    notifyListeners();
  }

  Future<bool> isSavedCheking(postId) async {
  DocumentReference savedPostRef = FirebaseFirestore.instance
      .collection('users')
      .doc(
        FirebaseAuth.instance.currentUser!.uid,
      )
      .collection('savedImages')
      .doc(postId);

  DocumentSnapshot savedPostSanp = await savedPostRef.get();
  if (savedPostSanp.exists) {
    return true;
  } else {
    return false;
  }
}
}
