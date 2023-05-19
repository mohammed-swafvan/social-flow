import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_flow/models/post_model.dart';
import 'package:social_flow/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //////// upload the post //////////
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
}
