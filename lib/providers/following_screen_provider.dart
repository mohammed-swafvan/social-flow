import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class FollowingScreenProvider extends ChangeNotifier {
  List following = [];
  List<UserModel>? userModelList;
  bool isLoading = false;
  getUserFollowing({required String userUid}) async {
    isLoading = true;
    userModelList = [];
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
      following = userSnap.data()!['following'];

      for (var uid in following) {
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
