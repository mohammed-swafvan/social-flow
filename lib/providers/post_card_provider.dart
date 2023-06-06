import 'package:flutter/material.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class PostCardProvider extends ChangeNotifier {
  bool isLikeAnimating = false;
  int commentLength = 0;
  bool isPostSaved = false;

  likeAnimationTrue() {
    isLikeAnimating = true;
    notifyListeners();
  }

  likeAnimationFalse() {
    isLikeAnimating = false;
    notifyListeners();
  }

  saveImageChecking(snap) async {
    isPostSaved = await FirestoreMethods().isSavedCheking(snap['postId']);
    notifyListeners();
  }
}
