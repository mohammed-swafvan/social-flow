import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/bottom_nav.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/auth_services.dart';

class SignInNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool passWordVisibility = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void changePasswordVisibility() {
    passWordVisibility = !passWordVisibility;
    notifyListeners();
  }

  void disposeControllers() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> userLogin({required BuildContext context, required String email, required String password}) async {
    if (email.isEmpty && password.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Fields are required");
    } else if (email.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your email");
    } else if (password.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your password");
    } else if (email.length < 10) {
      emailController.clear();
      notifyListeners();
      return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
    }

    String emailValidation = email.substring(email.length - 10);
    if (emailValidation != "@gmail.com" || email.length < 13) {
      emailController.clear();
      notifyListeners();
      return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
    }

    isLoading = true;
    notifyListeners();

    String result = await AuthServices().userLogin(email: email, password: password);
    isLoading = false;
    disposeControllers();
    notifyListeners();
    if (result != "success") {
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: result);
      }
    }

    if (context.mounted && result == "success") {
      String userId = AuthServices().getUserId();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(uid: userId),
        ),
      );
    }
  }
}
