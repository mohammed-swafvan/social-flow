import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/post_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/firestore_services.dart';

class PostCardNotifier extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? postCommentStream;
  Stream<bool>? savedPostExistStream;
  bool isLikeAnimating = false;
  bool get likeAnimation => isLikeAnimating;

  set likeAnimation(bool value) {
    isLikeAnimating = value;
    notifyListeners();
  }

  getCommentsStream({required String postId}) async {
    postCommentStream = FirestoreServices().getPostCommentStream(postId: postId);
  }

  getSavedPostStream({required String postId}) async {
    savedPostExistStream = FirestoreServices().getSavedPostExistStream(postId: postId);
  }

  Future<void> likePost({required String postId, required List likes}) async {
    await FirestoreServices().likePost(postId: postId, likes: likes);
    notifyListeners();
  }

  Future<void> savePost({
    required BuildContext context,
    required String uid,
    required String postUrl,
    required String description,
    required String username,
    required String postId,
    required Timestamp datePublished,
    required List likes,
  }) async {
    DateTime date = datePublished.toDate();
    final PostModel post = PostModel(
      description: description,
      uid: uid,
      username: username,
      postId: postId,
      datePublished: date,
      postUrl: postUrl,
      profImage: '',
      likes: likes,
    );

    String result = await FirestoreServices().savePost(post: post);
    if (context.mounted) {
      Utils().customSnackBar(context: context, content: result);
    }
    notifyListeners();
  }
}
