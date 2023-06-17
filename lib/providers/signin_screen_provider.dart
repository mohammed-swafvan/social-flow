// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';

class SignupScreenProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  bool profExsting = false;
  Uint8List? image;

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    image = img;
    profExsting = true;
    notifyListeners();
  }

  signUpUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String res = await AuthMethods().singnUpUser(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      file: image!,
    );

    isLoading = false;
    notifyListeners();

    if (context.mounted) {}
    if (res != "success") {
      showSnackbar(res, context);
      isLoading = false;
      notifyListeners();
    } else {
      String userId = AuthMethods().getUserUid();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(userId: userId,),
            webScreenLayout: const WebScreenLayout(),
          ),
        ),
      );
      disposeControllers(context);
      isLoading = false;
      notifyListeners();
    }
  }

  disposeControllers(context) {
    final provider = Provider.of<SignupScreenProvider>(context, listen: false);
    provider.emailController.clear();
    provider.passwordController.clear();
    provider.bioController.clear();
    provider.usernameController.clear();
  }
}
