import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/provider/edit_notifier.dart';
import 'package:social_flow/provider/forgot_password_notifier.dart';
import 'package:social_flow/provider/sign_in_notifier.dart';
import 'package:social_flow/provider/sign_up_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        elevation: 5.0,
        shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: screenWidth / 3,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                CustomColors.firstGradientColor,
                CustomColors.secondGradientColor,
              ],
              begin: Alignment.centerLeft,
              end: AlignmentDirectional.centerEnd,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Consumer<ForgotPasswordNotifier>(
            builder: (context, forgotPasswordNotifier, _) {
              return Consumer<SignInNotifier>(
                builder: (context, signInNotifier, _) {
                  return Consumer<SignUpNotifier>(
                    builder: (context, signUPNotifier, _) {
                      return Consumer<EditNotifier>(
                        builder: (context, editNotifier, _) {
                          if (signUPNotifier.isLoading ||
                              signInNotifier.isLoading ||
                              forgotPasswordNotifier.isLoading ||
                              editNotifier.isLoading) {
                            return const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 3,
                              ),
                            );
                          }
                          return Text(
                            text,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
