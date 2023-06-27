// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';

class LoginScreenProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool visibility = true;

  visibilityChanging() {
    visibility = !visibility;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext ctx) async {
    isLoading = true;
    notifyListeners();

    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      String userId = AuthMethods().getUserUid();
      disposeController(ctx);
      isLoading = false;
      notifyListeners();

      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(
              userId: userId,
            ),
            webScreenLayout: const WebScreenLayout(),
          ),
        ),
      );
      notifyListeners();
    } else {
      isLoading = false;
      showSnackbar(res, ctx);
      notifyListeners();
    }
  }

  disposeController(context) {
    final provider = Provider.of<LoginScreenProvider>(context, listen: false);
    provider.emailController.clear();
    provider.passwordController.clear();
  }
}
