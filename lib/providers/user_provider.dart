import 'package:flutter/material.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  AuthMethods authMethod = AuthMethods();

  UserModel get getUser => userModel!;

  Future<void> refreshUser() async {
    UserModel user = await authMethod.getUserDetails();
    userModel = user;
    notifyListeners();
  }
}
