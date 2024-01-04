import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/services/auth_services.dart';

class UserNotifier extends ChangeNotifier {
  late UserModel userModel;
  AuthServices authServices = AuthServices();

  UserModel get getUser => userModel;

  Future<void> refreshUser() async {
    UserModel user = await authServices.getUserDetails();
    userModel = user;
    notifyListeners();
  }
}
