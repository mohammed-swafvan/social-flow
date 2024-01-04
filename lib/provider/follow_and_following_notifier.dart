import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/firestore_services.dart';

class FollowAndFollowingNotifier extends ChangeNotifier {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? userStream;
  List<UserModel> users = [];
  List usersIdList = [];
  bool isLoading = false;
  bool isFollowLoading = false;

  getUserStream() async {
    userStream = FirestoreServices().getUserStream();
  }

  Future<void> followUser({required BuildContext context, required String uid}) async {
    isFollowLoading = true;
    notifyListeners();
    String result = '';
    result = await FirestoreServices().followUser(uid: uid);
    if (context.mounted) {
      Utils().customSnackBar(context: context, content: result);
    }
    isFollowLoading = false;
    notifyListeners();
  }

  Future<void> getTargeteUsers({required String title, required String uid}) async {
    isLoading = false;
    notifyListeners();
    users.clear();
    usersIdList.clear();
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirestoreServices().getUser(uid: uid);
    if (title == 'Followers') {
      usersIdList = snapshot.data()!['followers'];
    } else {
      usersIdList = snapshot.data()!['following'];
    }

    for (var userId in usersIdList) {
      DocumentSnapshot<Map<String, dynamic>> snap = await FirestoreServices().getUser(uid: userId);
      users.add(
        UserModel(
          uid: snap['uid'],
          username: snap['username'],
          name: snap['name'],
          email: snap['email'],
          photoUrl: snap['photoUrl'],
          bio: snap['bio'],
          category: snap['category'],
          followers: snap['followers'],
          following: snap['following'],
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
