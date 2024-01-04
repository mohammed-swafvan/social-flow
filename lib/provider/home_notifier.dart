import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/services/firestore_services.dart';

class HomeNotifier extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>>? postStream;

  getPostStream() async {
    postStream = FirestoreServices().getAllPostStream();
    notifyListeners();
  }
}
