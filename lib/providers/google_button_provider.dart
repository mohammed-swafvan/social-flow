import 'package:flutter/material.dart';

class GoogleButtonProvider extends ChangeNotifier {
  bool isSignIn = false;

  signInTrue() {
    isSignIn = true;
    notifyListeners();
  }

  signInFalse() {
    isSignIn = false;
    notifyListeners();
  }

}
