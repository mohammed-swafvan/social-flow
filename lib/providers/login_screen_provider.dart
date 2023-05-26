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

  Future<void> loginUser(BuildContext ctx) async {
    isLoading = true;
    notifyListeners();

    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (ctx.mounted) {}
    if (res == "success") {
      isLoading = false;
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
      disposeController(ctx);
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
