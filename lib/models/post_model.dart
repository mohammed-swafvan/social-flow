import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;

  PostModel({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes" : likes,
      };

  static PostModel fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return PostModel(
      description: snapShot['description'],
      uid: snap['uid'],
      username: snapShot['username'],
      postId: snapShot['postId'],
      datePublished: snapShot['datePublished'],
      postUrl: snapShot['postUrl'],
      profImage: snapShot['profImage'],
      likes: snapShot['likes'],
    );
  }
}
