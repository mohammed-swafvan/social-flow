import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/bottom_nav.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/auth_services.dart';

class SignUpNotifier extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  passWordVisibilityChange() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  confirmPassWordVisibilityChange() {
    confirmPasswordVisibility = !confirmPasswordVisibility;
    notifyListeners();
  }

  disposeController() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> userRegistratio({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.isEmpty && username.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Fields are required");
    } else if (email.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your email");
    } else if (username.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your user name");
    } else if (password.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your password");
    } else if (confirmPassword.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your confirmation password");
    } else if (password != confirmPassword) {
      return Utils().customSnackBar(context: context, content: "Please confirm your password");
    } else if (password.length < 6) {
      return Utils().customSnackBar(context: context, content: "Weak password");
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

    String result = await AuthServices().userRegistration(
      username: username,
      email: email,
      password: password,
    );

    isLoading = false;
    disposeController();
    notifyListeners();

    if (result != "success") {
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: result);
      }
    }

    if (context.mounted && result == 'success') {
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
