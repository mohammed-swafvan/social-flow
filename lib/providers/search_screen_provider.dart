import 'package:flutter/material.dart';

class SearchScreenProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;

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
