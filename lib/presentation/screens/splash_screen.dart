import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/login_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/logo.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToMainPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                kHeight10,
                const SocilaFlowLogo(radius: 110),
                kHeight10,
                CustomTextWidget(
                  name: "Social Flow",
                  size: 28,
                  fontWeight: FontWeight.bold,
                  textColor: kYellowColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goToMainPage() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Main()));
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              String uid = user.uid;
              return ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(
                  userId: uid,
                ),
                webScreenLayout: MobileScreenLayout(
                  userId: uid,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Some Error Occured",
                  style: TextStyle(color: kWhiteColor),
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressWidget(),
            );
          }
          return const LoginScreen();
        });
  }
}
