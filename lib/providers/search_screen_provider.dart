import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';

class SearchScreenProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  List<UserModel> allUsersForSearching = [];
  List<UserModel> foundedUsers = [];

  getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').get();
      allUsersForSearching.clear();
      for (QueryDocumentSnapshot<Map<String, dynamic>> document in snapshot.docs) {
        Map<String, dynamic> data = document.data();
        allUsersForSearching.add(
          UserModel(
            email: data['email'],
            uid: data['uid'],
            photoUrl: data['photoUrl'],
            username: data['username'],
            bio: data['bio'],
            followers: data['followers'],
            following: data['following'],
            category: data['category'],
            name: data['name'],
          ),
        );
      }
      log(allUsersForSearching.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  runFilter() {
    List<UserModel> result = [];
    if (searchController.text.isEmpty) {
      result = [];
    } else {
      result = allUsersForSearching
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
