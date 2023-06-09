import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  List<UserModel> allUsersUsername = [];
  List<UserModel> foundedUsers = [];

  getAllUsersUsername() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> document in snapshot.docs) {
        Map<String, dynamic> data = document.data();
        String userName = data['username'];
        String photoUrl = data['photoUrl'];
        String uid = data['uid'];

        allUsersUsername.add(
          UserModel(
            email: '',
            uid: uid,
            photoUrl: photoUrl,
            username: userName,
            bio: '',
            followers: [],
            following: [],
          ),
        );
      }
      allUsersUsername = allUsersUsername.toSet().toList();
    } catch (e) {
      log(e.toString());
    }
  }

  runFilter() {
    List<UserModel> result = [];
    if (searchController.text.isEmpty) {
      result = [];
    } else {
      result = allUsersUsername
          .where((element) => element.username.toLowerCase().startsWith(searchController.text.toLowerCase()))
          .toList();
    }

    foundedUsers = result;
    notifyListeners();
  }

  showUser() {
    isShowUser = true;
    notifyListeners();
  }

  hideUser() {
    isShowUser = false;
    notifyListeners();
  }

  disposeSearchController() {
    searchController.clear();
    isShowUser = false;
    notifyListeners();
  }
}
