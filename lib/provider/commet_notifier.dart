import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/services/firestore_services.dart';

class CommentNotifier extends ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? commetsStream;

  getCommentStream({required String postId}) async {
    commetsStream = FirestoreServices().getPostCommentStream(postId: postId);
    notifyListeners();
  }

  Future<void> sendComment({
    required BuildContext context,
    required String postId,
    required String comment,
    required String userProfPic,
    required String username,
    required String userUid,
  }) async {
    isLoading = true;
    notifyListeners();
    await FirestoreServices().uploadComment(
      context: context,
      postId: postId,
      comment: comment,
      userProfPic: userProfPic,
      username: username,
      userUid: userUid,
    );
    isLoading = false;
    commentController.clear();
    notifyListeners();
  }

  Future<void> likeComment({required String postId, required String commentId}) async {
    await FirestoreServices().likeComment(postId: postId, commentId: commentId);
  }
}
