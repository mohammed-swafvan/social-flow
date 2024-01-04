import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/sign_up_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_container.dart';
import 'package:social_flow/presentation/widgets/auth_button.dart';
import 'package:social_flow/presentation/widgets/auth_text_field_box.dart';
import 'package:social_flow/provider/forgot_password_notifier.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                              'Password Recovery',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Enter your email',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSize.height15,
                    FadeInRight(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Material(
                          elevation: 6.0,
                          shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            height: screenHeight / 3,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Consumer<ForgotPasswordNotifier>(
                              builder: (context, notifier, _) {
                                return Form(
                                  key: notifier.formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(' Email', style: Theme.of(context).textTheme.labelLarge),
                                      CustomSize.height5,
                                      AuthTextFieldBox(
                                        isAuthentication: true,
                                        controller: notifier.emailController,
                                        icon: Icons.mail_outlined,
                                        hintText: "Email",
                                      ),
                                      CustomSize.height40,
                                      InkWell(
                                        onTap: () async {
                                          if (notifier.formKey.currentState!.validate()) {
                                            await notifier.resetPassword(
                                              context: context,
                                              email: notifier.emailController.text,
                                            );
                                          }
                                        },
                                        child: const AuthButton(text: "Send Email"),
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
                    Consumer<ForgotPasswordNotifier>(
                      builder: (context, notifier, _) {
                        return FadeInLeft(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Account? ", style: Theme.of(context).textTheme.labelLarge),
                              InkWell(
                                onTap: () {
                                  notifier.emailController.clear();
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
