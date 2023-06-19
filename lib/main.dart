import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/splash_screen.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/providers/add_post_provider.dart';
import 'package:social_flow/providers/bottom_nav_provider.dart';
import 'package:social_flow/providers/chat_provider.dart';
import 'package:social_flow/providers/edit_screen_provider.dart';
import 'package:social_flow/providers/followers_provider.dart';
import 'package:social_flow/providers/following_screen_provider.dart';
import 'package:social_flow/providers/google_button_provider.dart';
import 'package:social_flow/providers/login_screen_provider.dart';
import 'package:social_flow/providers/post_card_provider.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
import 'package:social_flow/providers/search_screen_provider.dart';
import 'package:social_flow/providers/signin_screen_provider.dart';
import 'package:social_flow/providers/single_post_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDubznabg-S_y-4Xi5PcrYPj3PM-qVD9H4",
        appId: "1:79279217626:web:3cdf547bf3645c3c75bee3",
        messagingSenderId: "79279217626",
        projectId: "social-flow-clone",
        storageBucket: "social-flow-clone.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginScreenProvider()),
        ChangeNotifierProvider(create: (_) => SignupScreenProvider()),
        ChangeNotifierProvider(create: (_) => GoogleButtonProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AddPostProvider()),
        ChangeNotifierProvider(create: (_) => ProfileScreenProvider()),
        ChangeNotifierProvider(create: (_) => PostCardProvider()),
        ChangeNotifierProvider(create: (_) => SinglePostProvider()),
        ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (_) => FollowerScreenProvider()),
        ChangeNotifierProvider(create: (_) => FollowingScreenProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => EditScreenProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Flow',
        theme: themeData(),
        home: const SplashScreen(),
      ),
    );
  }
}
