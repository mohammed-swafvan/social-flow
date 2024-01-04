import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/forgot_password_screen.dart';
import 'package:social_flow/presentation/screens/sign_up_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_container.dart';
import 'package:social_flow/presentation/widgets/auth_button.dart';
import 'package:social_flow/presentation/widgets/auth_text_field_box.dart';
import 'package:social_flow/provider/sign_in_notifier.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              const GradientContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    FadeInDown(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'SignIn',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Login to your Account',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSize.height15,
                    FadeInLeft(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Material(
                          elevation: 6.0,
                          shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            height: screenHeight / 2,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Consumer<SignInNotifier>(
                              builder: (context, notifier, _) {
                                return Form(
                                  key: notifier.formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(' Email', style: Theme.of(context).textTheme.labelLarge),
                                      CustomSize.height5,
                                      AuthTextFieldBox(
                                        isAuthentication: true,
                                        controller: notifier.emailController,
                                        icon: Icons.mail_outlined,
                                        hintText: "Email",
                                      ),
                                      CustomSize.height25,
                                      Text(' Password', style: Theme.of(context).textTheme.labelLarge),
                                      CustomSize.height5,
                                      AuthTextFieldBox(
                                        isAuthentication: true,
                                        controller: notifier.passwordController,
                                        icon: Icons.password,
                                        hintText: "Password",
                                        visibleButtonTap: () {
                                          notifier.changePasswordVisibility();
                                        },
                                        isVibleOff: notifier.passWordVisibility,
                                      ),
                                      CustomSize.height5,
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const ForgotPasswordScreen(),
                                            ),
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('Forgot Password? ', style: Theme.of(context).textTheme.labelMedium),
                                        ),
                                      ),
                                      CustomSize.height40,
                                      InkWell(
                                        onTap: () async {
                                          if (notifier.formKey.currentState!.validate()) {
                                            await notifier.userLogin(
                                              context: context,
                                              email: notifier.emailController.text,
                                              password: notifier.passwordController.text,
                                            );
                                          }
                                        },
                                        child: const AuthButton(text: "SignIn"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consumer<SignInNotifier>(
                      builder: (context, notifier, _) {
                        return FadeInRight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Account? ", style: Theme.of(context).textTheme.labelLarge),
                              InkWell(
                                onTap: () {
                                  notifier.disposeControllers();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
