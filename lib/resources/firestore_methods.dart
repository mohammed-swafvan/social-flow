import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/post_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid, String username, String profImage) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      PostModel postModel = PostModel(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      firestore.collection('posts').doc(postId).set(
            postModel.toJson(),
          );

      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Future<void> likePost(BuildContext context, String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  Future<void> followUser({
    required BuildContext context,
    required String uid,
    required String followId,
  }) async {
    try {
      DocumentSnapshot snap = await firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  Future<void> postComment(BuildContext context, String postId, String text, String uid, String name, String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  savePost(
    context,
    String postId,
    String username,
    String currentUserUid,
    datePublished,
    String postUrl,
    String description,
    List likes,
  ) async {
    DocumentReference savedPostRef = firestore.collection('users').doc(currentUserUid).collection('savedImages').doc(postId);
    DocumentSnapshot savedPostSnap = await savedPostRef.get();

    try {
      if (savedPostSnap.exists) {
        await savedPostRef.delete();
        showSnackbar("Post Removed", context);
      } else {
        await savedPostRef.set({
          'username': username,
          'currentUserUid': currentUserUid,
          'postId': postId,
          'postUrl': postUrl,
          'datePublished': datePublished,
          'description': description,
          'likes': likes,
        });
        showSnackbar("Post Saved", context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  ////// is post saved or not saved checking /////
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

  Future<bool> isFollowChecking(String uid) async {
    DocumentReference user = FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot followersSnap = await user.get();

    if (followersSnap['followers'].contains(FirebaseAuth.instance.currentUser!.uid)) {
      return true;
    } else {
      return false;
    }
  }

  deletePost(String postId, context) async {
    try {
      await firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  deleteComment(BuildContext context, postId, commentId) async {
    try {
      await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).delete();
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }
}
