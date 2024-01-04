import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/bottom_nav.dart';
import 'package:social_flow/presentation/screens/sign_in_screen.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: GradientCircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
            String userId = user.uid;
            return BottomNav(uid: userId);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Some Error Occured",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        }

        return const SignInScreen();
      },
    );
  }
}
