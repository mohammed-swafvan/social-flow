import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel({
    required this.uid,
    required this.username,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.bio,
    required this.category,
    required this.followers,
    required this.following,
  });

  final String uid;
  final String username;
  final String name;
  final String email;
  final String photoUrl;
  final String bio;
  final String category;
  final List followers;
  final List following;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "category": category,
        "followers": followers,
        "following": following,
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
