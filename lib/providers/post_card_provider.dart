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
  
}
