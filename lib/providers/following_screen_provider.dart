import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class FollowingScreenProvider extends ChangeNotifier {
  List following = [];
  List<UserModel>? userModelList = [];
  bool isLoading = false;
  getUserFollowing({required String userUid}) async {
    isLoading = true;
    userModelList = [];
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
      following = userSnap.data()!['following'];

      for (var uid in following) {
        var followingDetails = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        userModelList!.add(
          UserModel(
            email: followingDetails['email'],
            uid: uid,
            photoUrl: followingDetails['photoUrl'],
            username: followingDetails['username'],
            bio: followingDetails['bio'],
            followers: followingDetails['followers'],
            following: followingDetails['following'],
            name: followingDetails['name'],
            category: followingDetails['category'],
          ),
        );
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log('$e ++++++++++');
      isLoading = false;
      notifyListeners();
    }
  }
}
