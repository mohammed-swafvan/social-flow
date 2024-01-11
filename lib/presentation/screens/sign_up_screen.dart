import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/sign_in_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_container.dart';
import 'package:social_flow/presentation/widgets/auth_button.dart';
import 'package:social_flow/presentation/widgets/auth_text_field_box.dart';
import 'package:social_flow/provider/sign_up_notifier.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
                              'SignUp',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Create a new Account',
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
                            height: screenHeight / 1.5,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Consumer<SignUpNotifier>(
                              builder: (context, notifier, _) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(' User Name', style: Theme.of(context).textTheme.labelLarge),
                                    CustomSize.height5,
                                    AuthTextFieldBox(
                                      isAuthentication: true,
                                      controller: notifier.userNameController,
                                      icon: Icons.person_2_outlined,
                                      hintText: "User Name",
                                    ),
                                    CustomSize.height25,
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
                                        notifier.passWordVisibilityChange();
                                      },
                                      isVibleOff: notifier.passwordVisibility,
                                    ),
                                    CustomSize.height25,
                                    Text(' Confirm Password', style: Theme.of(context).textTheme.labelLarge),
                                    CustomSize.height5,
                                    AuthTextFieldBox(
                                      isAuthentication: true,
                                      controller: notifier.confirmPasswordController,
                                      icon: Icons.password,
                                      hintText: "Confirm Password",
                                      visibleButtonTap: () {
                                        notifier.confirmPassWordVisibilityChange();
                                      },
                                      isVibleOff: notifier.confirmPasswordVisibility,
                                    ),
                                    CustomSize.height40,
                                    InkWell(
                                      onTap: () async {
                                        await notifier.userRegistratio(
                                          context: context,
                                          username: notifier.userNameController.text,
                                          email: notifier.emailController.text,
                                          password: notifier.passwordController.text,
                                          confirmPassword: notifier.confirmPasswordController.text,
                                        );
                                      },
                                      child: const AuthButton(text: "SIGN UP"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consumer<SignUpNotifier>(
                      builder: (context, notifier, _) {
                        return FadeInLeft(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an Account? ", style: Theme.of(context).textTheme.labelLarge),
                              InkWell(
                                onTap: () {
                                  notifier.disposeController();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignInScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'SignIn',
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

  void initialization() {
    SignUpNotifier notifier = Provider.of<SignUpNotifier>(context, listen: false);
    notifier.disposeController();
  }
}
