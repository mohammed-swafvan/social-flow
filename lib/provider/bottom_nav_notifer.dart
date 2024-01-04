import 'package:flutter/material.dart';

class BottomNavNotifier extends ChangeNotifier {
  int page = 0;

  onPageChanged(int currentPage) {
    page = currentPage;
    notifyListeners();
  }
}
