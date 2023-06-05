import 'package:flutter/material.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class SinglePostProvider with ChangeNotifier {
  bool alreadyLike = false;
  int likeLength = 0;

  likePost(BuildContext context, snap, currentUserUid) async {
    await FirestoreMethods().likePost(
      context,
      snap['postId'],
      currentUserUid,
      snap['likes'],
    );
    notifyListeners();
  }

  likeContains(snap, currentUserUid) async {
    alreadyLike = await snap['likes'].contains(currentUserUid);
    notifyListeners();
  }

  likeButtonManaging() {
    alreadyLike = !alreadyLike;
    notifyListeners();
  }

  likeLengthInitialize(snap) {
    likeLength = snap['likes'].length;
    notifyListeners();
  }

  likeLengthCounting() {
    if (alreadyLike) {
      likeLength = likeLength + 1;
    } else {
      likeLength = likeLength - 1;
    }
  }
}
