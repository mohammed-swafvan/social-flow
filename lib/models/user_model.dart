import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String name;
  final String category;

  UserModel( {
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.name,
    required this.category, 
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "name": name,
        "category": category,
      };

  static UserModel fromSnapShot(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapShot['email'],
      uid: snap['uid'],
      photoUrl: snapShot['photoUrl'],
      username: snapShot['username'],
      bio: snapShot['bio'],
      followers: snapShot['followers'],
      following: snapShot['following'],
      name: snapShot['name'],
      category: snapShot['category'],
    );
  }
}
