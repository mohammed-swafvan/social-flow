import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class FollowerProvider extends ChangeNotifier {
  var userData = {};
  List followers = [];
  List<UserModel>? userModelList;
  bool isLoading = false;
  getUserFollowers({required String userUid}) async {
    isLoading = true;
    userModelList = [];
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(userUid).get();

      var fullSnap = await FirebaseFirestore.instance.collection('users').get();
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'];

      for (var uid in followers) {
        for (var element in fullSnap.docs) {
          if (uid == element.data()['uid']) {
            userModelList!.add(
              UserModel(
                email: element['email'],
                uid: uid,
                photoUrl: element['photoUrl'],
                username: element['username'],
                bio: element['bio'],
                followers: element['followers'],
                following: element['following'],
              ),
            );
            break;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
