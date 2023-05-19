import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_flow/presentation/screens/login_screen/login_screen.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/presentation/widgets/text_field_input.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  bool profExsting = false;

  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 0.98,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(image!),
                          )
                        : const CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage("assets/images/prof.jpeg"),
                          ),
                    Positioned(
                      bottom: -10,
                      right: 0,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: kWhiteColor,
                        ),
                      ),
                    )
                  ],
                ),
                kSizedBox30,
                kSizedBox30,
                TextFieldWidget(
                  textEdingController: usernameController,
                  hintText: "enter your username",
                  labelText: "username",
                  textInputType: TextInputType.text,
                ),
                kSizedBox15,
                TextFieldWidget(
                  textEdingController: emailController,
                  hintText: "enter your email",
                  labelText: "email",
                  textInputType: TextInputType.emailAddress,
                ),
                kSizedBox15,
                TextFieldWidget(
                  textEdingController: passwordController,
                  hintText: "enter your password",
                  labelText: "password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                kSizedBox15,
                TextFieldWidget(
                  textEdingController: bioController,
                  hintText: "enter your bio",
                  labelText: "bio",
                  textInputType: TextInputType.text,
                ),
                kSizedBox30,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: () {
                      if (profExsting) {
                        signUpUser();
                      } else {
                        showSnackbar("please add profile picture", context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: kMainColor,
                      ),
                      child: isLoading
                          ? const CircularProgressWidget()
                          : CustomTextWidget(
                              name: "Sign up",
                              size: 18,
                              fontWeight: FontWeight.w500,
                              textColor: kWhiteColor,
                            ),
                    ),
                  ),
                ),
                kSizedBox20,
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Do you have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
      profExsting = true;
    });
  }

  signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().singnUpUser(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      file: image!,
    );

    setState(() {
      isLoading = false;
    });

    if (res != "success") {
      // ignore: use_build_context_synchronously
      showSnackbar(res, context);
    }else{
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }
}
