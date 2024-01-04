import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/sign_in_screen.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/auth_services.dart';

class MenuNotifier extends ChangeNotifier {
  bool isLoading = false;

  Future<void> logOutUser({required BuildContext context, required String username}) async {
    return Utils().showDialogBox(
      context: context,
      onTap: () async {
        isLoading = true;
        notifyListeners();
        Navigator.of(context).pop();
        try {
          await AuthServices().userSignOut();
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            Navigator.pop(context);
            Utils().customSnackBar(context: context, content: "Something went wrong, please try again!");
          }
        }
        isLoading = false;
        notifyListeners();
      },
      title: "Log Out!",
      content: "Are you sure $username, You want to log out?",
    );
  }
}
