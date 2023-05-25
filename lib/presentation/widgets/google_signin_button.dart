// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/google_button_provider.dart';
import 'package:social_flow/resources/auth_methods.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleButtonProvider>(builder: (context, value, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: value.isSignIn
            ? const CircularProgressWidget()
            : OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: () async {
                  value.signInTrue();
                  User? user = await AuthMethods().signInWithGoogle(context: context);

                  if (user != null) {
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
                  value.signInFalse();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/google_logo.png",
                        width: 28,
                        height: 28,
                      ),
                      CustomTextWidget(
                        name: "Continue With Google",
                        size: 16,
                        fontWeight: FontWeight.bold,
                        textColor: kBackgroundColor.withOpacity(0.7),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kBackgroundColor.withOpacity(0.7),
                        size: 18,
                      )
                    ],
                  ),
                )),
      );
    });
  }
}
