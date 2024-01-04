import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/entry_point.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_text.dart';
import 'package:social_flow/theme/socia_flow_logo.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToEntryPoint();
  }

  Future<void> goToEntryPoint() async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EntryPoint()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.scaffoldBackgroundColor,
              Theme.of(context).brightness == Brightness.light ? Colors.white60 : Colors.black87
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(seconds: 1),
              child: SocialFlowLogo(
                backGroundRadius: screenWidth / 1.6,
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 100,
                      color: CustomColors.socialFlowLabelColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            CustomSize.height20,
            FadeInUp(
              duration: const Duration(seconds: 1),
              child: GradientText(
                text: "Social Flow",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
                gradient: const LinearGradient(
                  colors: [
                    CustomColors.firstGradientColor,
                    CustomColors.secondGradientColor,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
