import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/sign_up_screen.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/google_signin_button.dart';
import 'package:social_flow/presentation/widgets/logo.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/presentation/widgets/text_field_input.dart';
import 'package:social_flow/providers/login_screen_provider.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight * 0.96,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  const SocilaFlowLogo(radius: 80),
                  kHeight30,
                  kHeight20,
                  Consumer<LoginScreenProvider>(
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
                  Consumer<LoginScreenProvider>(
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
                  kHeight20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Consumer<LoginScreenProvider>(
                      builder: (context, value, child) {
                        return InkWell(
                          onTap: () async {
                            value.loginUser(context);
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
                                    name: "Log in",
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                    textColor: kWhiteColor,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  kHeight30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLine(screenWidth),
                        CustomTextWidget(name: "or", size: 16, fontWeight: FontWeight.bold, textColor: kMainColor),
                        customLine(screenWidth),
                      ],
                    ),
                  ),
                  kHeight30,
                  FutureBuilder(
                    future: AuthMethods().initializeFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error Initializing Firebase");
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressWidget();
                      }
                      return const GoogleSignInButton();
                    },
                  ),
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
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Consumer<LoginScreenProvider>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                              value.disposeController(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Sign up",
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
          ],
        ),
      ),
    );
  }
}
