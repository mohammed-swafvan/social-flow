import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_flow/models/chat_model.dart';
import 'package:social_flow/models/post_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/storage_services.dart';
import 'package:random_string/random_string.dart';

class FirestoreServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection('users').get();
    return snapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection('users').doc(uid).get();
    return snapshot;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    return firestore.collection('users').doc(auth.currentUser!.uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPostStream() {
    return firestore.collection('posts').orderBy("datePublished", descending: true).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserPostStream({required String uid}) {
    return firestore.collection('posts').where('uid', isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSavedPostStream({required String uid}) {
    return firestore.collection('users').doc(uid).collection('saved_posts').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPostCommentStream({required String postId}) {
    return firestore.collection('posts').doc(postId).collection('comments').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream({required String chatRoomId}) {
    return firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  Stream<bool> getSavedPostExistStream({required String postId}) {
    String currentUid = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(currentUid)
        .collection('saved_posts')
        .doc(postId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }

  Future<String> uploadPost({
    required Uint8List file,
    required String username,
    required String profUrl,
    required String description,
  }) async {
    String result = "Some error occurred while uploading";
    try {
      String postUrl = await StorageServices().uploadImageToStorage(file: file, imageTypeName: 'posts', isPost: true);
      String postId = randomAlphaNumeric(12);
      PostModel post = PostModel(
        description: description,
        uid: auth.currentUser!.uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profImage: profUrl,
        likes: [],
      );
      await firestore.collection('posts').doc(postId).set(post.toJson());
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> savePost({required PostModel post}) async {
    String currentUid = auth.currentUser!.uid;
    String res = "Some error occurred";

    try {
      DocumentReference doc = firestore.collection('users').doc(currentUid).collection('saved_posts').doc(post.postId);
      DocumentSnapshot snap = await doc.get();
      if (snap.exists) {
        await doc.delete();
        res = "Unsaved the post";
        return res;
      } else {
        await firestore.collection('users').doc(currentUid).collection('saved_posts').doc(post.postId).set(post.toJson());
        res = "Post is saved";
        return res;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> uploadChat({required ChatModel chat}) async {
    try {
      firestore.collection('chat_room').doc(chat.chatRoomId).collection('chats').doc(chat.chatId).set(
            chat.toJson(),
          );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> likePost({required String postId, required List likes}) async {
    final String userUid = auth.currentUser!.uid;
    try {
      if (likes.contains(userUid)) {
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([userUid]),
        });
      } else {
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([userUid]),
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> followUser({required String uid}) async {
    String res = '';
    try {
      final String currentUserId = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore.collection('users').doc(currentUserId).get();
      List following = (doc.data()! as dynamic)['following'];

      if (following.contains(uid)) {
        await firestore.collection('users').doc(currentUserId).update({
          'following': FieldValue.arrayRemove([uid]),
        });
        await firestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayRemove([currentUserId]),
        });
        res = 'Unfollowed';
      } else {
        await firestore.collection('users').doc(currentUserId).update({
          'following': FieldValue.arrayUnion([uid]),
        });
        await firestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayUnion([currentUserId]),
        });
        res = 'Following';
      }
    } catch (e) {
      res = 'Something went wrong';
    }
    return res;
  }

  Future<String> uploadComment({
    required BuildContext context,
    required String postId,
    required String comment,
    required String userProfPic,
    required String username,
    required String userUid,
  }) async {
    String result = "some error occurred";
    String commentId = randomAlphaNumeric(12);
    try {
      if (comment.trim().isNotEmpty) {
        await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'profile_pic': userProfPic,
          'username': username,
          'user_id': userUid,
          'comment': comment,
          'comment_id': commentId,
          'date_created': DateTime.now(),
          'is_author_liked': false,
        });
        result = 'success';
      } else {
        result = 'Write a comment';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> likeComment({required String postId, required String commentId}) async {
    DocumentSnapshot<Map<String, dynamic>> docSnap =
        await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).get();
    if (docSnap.data()!['is_author_liked']) {
      await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
        'is_author_liked': false,
      });
    } else {
      await firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
        'is_author_liked': true,
      });
    }
  }

  Future<void> deletePost({required String postId}) async {
    await firestore.collection('posts').doc(postId).delete();
    QuerySnapshot<Map<String, dynamic>> documents = await firestore.collection('users').get();
    for (var doc in documents.docs) {
      DocumentReference savedPostRef = firestore.collection('users').doc(doc.data()['uid']).collection('saved_posts').doc(postId);
      await savedPostRef.delete();
    }
  }

  Future<void> deleteMessage({required String chatRoomId, required String messageId}) async {
    return await firestore.collection('chat_room').doc(chatRoomId).collection('chats').doc(messageId).delete();
  }

  Future<String> updateUserDetails({
    required String username,
    required String updatedProf,
    required String name,
    required String category,
    required String bio,
  }) async {
    String uid = auth.currentUser!.uid;
    String result = "some error occurred";
    try {
      await firestore.collection('users').doc(uid).update({
        "username": username,
        "name": name,
        "photoUrl": updatedProf,
        "category": category,
        "bio": bio,
      });
      QuerySnapshot<Map<String, dynamic>> postQuerySnapshot =
          await firestore.collection('posts').where('uid', isEqualTo: uid).get();
      for (var documentSnapshot in postQuerySnapshot.docs) {
        var docRef = documentSnapshot.reference;
        await docRef.update({
          'profImage': updatedProf,
          "username": username,
        });
      }
      result = "Updated";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> updateProfilePhoto({required BuildContext context, required Uint8List file}) async {
    try {
      String photoUrl = await StorageServices().uploadImageToStorage(file: file, imageTypeName: 'prof', isPost: false);
      await firestore.collection('users').doc(auth.currentUser!.uid).update({
        "photoUrl": photoUrl,
      });
      QuerySnapshot<Map<String, dynamic>> postQuerySnapshot =
          await firestore.collection('posts').where('uid', isEqualTo: auth.currentUser!.uid).get();
      for (var documentSnapshot in postQuerySnapshot.docs) {
        var docRef = documentSnapshot.reference;
        await docRef.update({
          'profImage': photoUrl,
        });
      }
      if (context.mounted) {
        Utils().customSnackBar(context: context, content: "Profile picture updated successfully");
      }
    } catch (e) {
      if (context.mounted) {
        Utils().customSnackBar(context: context, content: e.toString());
      }
    }
  }
}
