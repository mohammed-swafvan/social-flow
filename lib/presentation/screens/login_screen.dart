import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/sign_up_screen.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/google_signin_button.dart';
import 'package:social_flow/presentation/widgets/logo.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/presentation/widgets/text_field_input.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
              TextFieldWidget(
                textEdingController: emailController,
                hintText: "enter your email",
                labelText: "email",
                textInputType: TextInputType.emailAddress,
              ),
              kHeight15,
              TextFieldWidget(
                textEdingController: passwordController,
                hintText: "enter your password",
                labelText: "password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              kHeight20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  onTap: loginUser,
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
                            name: "Log in",
                            size: 18,
                            fontWeight: FontWeight.w500,
                            textColor: kWhiteColor,
                          ),
                  ),
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
                  }),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
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
    } else {
      // ignore: use_build_context_synchronously
      showSnackbar(res, context);
    }

    setState(() {
      isLoading = false;
    });
  }
}
