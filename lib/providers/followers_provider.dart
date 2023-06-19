import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class FollowerScreenProvider extends ChangeNotifier {
  List followers = [];
  List<UserModel>? userModelList = [];
  bool isLoading = false;
  getUserFollowers({required String userUid}) async {
    isLoading = true;
    userModelList = [];
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
      followers = userSnap.data()!['followers'];

      for (var uid in followers) {
        var followersDetails = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        userModelList!.add(
          UserModel(
            email: followersDetails['email'],
            uid: uid,
            photoUrl: followersDetails['photoUrl'],
            username: followersDetails['username'],
            bio: followersDetails['bio'],
            followers: followersDetails['followers'],
            following: followersDetails['following'],
            name: followersDetails['name'],
            category: followersDetails['category'],
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
