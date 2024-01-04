import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/sign_in_screen.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/auth_services.dart';

class ForgotPasswordNotifier extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  Future<void> resetPassword({required BuildContext context, required String email}) async {
    if (email.isEmpty) {
      return Utils().customSnackBar(context: context, content: "Please enter your email");
    } else if (email.length < 10) {
      emailController.clear();
      notifyListeners();
      return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
    }

    String emailValidation = email.substring(email.length - 10);
    if (emailValidation != "@gmail.com" || email.length < 10 || email.length < 13) {
      emailController.clear();
      notifyListeners();
      return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
    }

    isLoading = true;
    notifyListeners();
    String result = await AuthServices().resetPassword(email: email);
    isLoading = false;
    emailController.clear();
    notifyListeners();
    if (result != "success") {
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: result);
      }
    }

    if (context.mounted) {
      Utils().customSnackBar(context: context, content: 'Password reset email has been sent');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }
}
