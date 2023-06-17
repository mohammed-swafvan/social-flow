
import 'package:flutter/material.dart';


class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  onButtonIconClick(int updatedIndex) {
    currentIndex = updatedIndex;
    notifyListeners();
  }
}
