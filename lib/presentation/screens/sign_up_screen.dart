import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/login_screen.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/presentation/widgets/text_field_input.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/providers/signin_screen_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 0.96,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Consumer<SignupScreenProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        value.image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: MemoryImage(value.image!),
                              )
                            : const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage("assets/images/prof.jpeg"),
                              ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              value.selectImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: kWhiteColor,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                kHeight30,
                kHeight30,
                Consumer<SignupScreenProvider>(
                  builder: (context, value, child) {
                    return TextFieldWidget(
                      textEdingController: value.usernameController,
                      hintText: "enter your username",
                      labelText: "username",
                      textInputType: TextInputType.text,
                    );
                  },
                ),
                kHeight15,
                Consumer<SignupScreenProvider>(
                  builder: (context, value, child) {
                    return TextFieldWidget(
                      textEdingController: value.emailController,
                      hintText: "enter your email",
                      labelText: "email",
                      textInputType: TextInputType.emailAddress,
                    );
                  },
                ),
                kHeight15,
                Consumer<SignupScreenProvider>(
                  builder: (context, value, child) {
                    return TextFieldWidget(
                      textEdingController: value.passwordController,
                      hintText: "enter your password",
                      labelText: "password",
                      textInputType: TextInputType.text,
                      isPass: true,
                    );
                  },
                ),
                kHeight15,
                Consumer<SignupScreenProvider>(
                  builder: (context, value, child) {
                    return TextFieldWidget(
                      textEdingController: value.bioController,
                      hintText: "enter your bio",
                      labelText: "bio",
                      textInputType: TextInputType.text,
                    );
                  },
                ),
                kHeight30,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Consumer<SignupScreenProvider>(
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          if (value.profExsting) {
                            value.signUpUser(context);
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
                          child: value.isLoading
                              ? const CircularProgressWidget()
                              : CustomTextWidget(
                                  name: "Sign up",
                                  size: 18,
                                  fontWeight: FontWeight.w500,
                                  textColor: kWhiteColor,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                kHeight20,
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
                    Consumer<SignupScreenProvider>(
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            value.disposeControllers(context);
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
                        );
                      },
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
}
