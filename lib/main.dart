import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/login_screen/login_screen.dart';
import 'package:social_flow/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/responsive/mobile_screen_layout.dart';
import 'package:social_flow/responsive/responsive_layout_screen.dart';
import 'package:social_flow/responsive/web_screen_layout.dart';
import 'package:social_flow/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDubznabg-S_y-4Xi5PcrYPj3PM-qVD9H4",
      appId: "1:79279217626:web:3cdf547bf3645c3c75bee3",
      messagingSenderId: "79279217626",
      projectId: "social-flow-clone",
      storageBucket: "social-flow-clone.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Flow',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout(),);
            }else if(snapshot.hasError){
              return Center(
                child: Text("Some Error Occured", style: TextStyle(color: kWhiteColor),),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressWidget(),);
          }

          return const LoginScreen();
        }
      );
  }
}
