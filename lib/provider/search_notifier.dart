import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/services/firestore_services.dart';

class SearchNotifier extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? postStream;
  final TextEditingController searchController = TextEditingController();
  bool hideUser = true;
  List<UserModel> allUsersData = [];
  List<UserModel> searchedUsers = [];
  bool isLoading = false;

  bool get hideUsers => hideUser;

  set hideUsers(bool value) {
    hideUser = value;
    notifyListeners();
  }

  Future<void> getPostStream() async {
    postStream = FirestoreServices().getAllPostStream();
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();
    allUsersData.clear();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirestoreServices().getAllUsers();
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      Map<String, dynamic> userData = doc.data()!;
      allUsersData.add(
        UserModel(
          uid: userData['uid'],
          username: userData['username'],
          name: userData['name'],
          email: userData['email'],
          photoUrl: userData['photoUrl'],
          bio: userData['bio'],
          category: userData['category'],
          followers: userData['followers'],
          following: userData['following'],
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }

  void filterUsers() {
    List<UserModel> result = [];
    result.clear();
    searchedUsers.clear();
    notifyListeners();
    if (searchController.text.isEmpty) {
      result = [];
    } else {
      String searchValue = searchController.text.toLowerCase();
      result = allUsersData
          .where(
            (element) =>
                element.username.toLowerCase().startsWith(searchValue) || element.name.toLowerCase().startsWith(searchValue),
          )
          .toList();
    }
    searchedUsers = result;
    notifyListeners();
  }
}
