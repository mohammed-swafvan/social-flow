import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/splash_screen.dart';
import 'package:social_flow/provider/bottom_nav_notifer.dart';
import 'package:social_flow/provider/chat_notifier.dart';
import 'package:social_flow/provider/commet_notifier.dart';
import 'package:social_flow/provider/create_post_notifier.dart';
import 'package:social_flow/provider/edit_notifier.dart';
import 'package:social_flow/provider/follow_and_following_notifier.dart';
import 'package:social_flow/provider/forgot_password_notifier.dart';
import 'package:social_flow/provider/home_notifier.dart';
import 'package:social_flow/provider/menu_notifier.dart';
import 'package:social_flow/provider/post_card_notifier.dart';
import 'package:social_flow/provider/profile_notifier.dart';
import 'package:social_flow/provider/search_notifier.dart';
import 'package:social_flow/provider/sign_in_notifier.dart';
import 'package:social_flow/provider/sign_up_notifier.dart';
import 'package:social_flow/provider/user_notifier.dart';
import 'package:social_flow/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Firebase.initializeApp().then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpNotifier()),
        ChangeNotifierProvider(create: (_) => SignInNotifier()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordNotifier()),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => BottomNavNotifier()),
        ChangeNotifierProvider(create: (_) => HomeNotifier()),
        ChangeNotifierProvider(create: (_) => PostCardNotifier()),
        ChangeNotifierProvider(create: (_) => FollowAndFollowingNotifier()),
        ChangeNotifierProvider(create: (_) => CommentNotifier()),
        ChangeNotifierProvider(create: (_) => SearchNotifier()),
        ChangeNotifierProvider(create: (_) => CreatePostNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
        ChangeNotifierProvider(create: (_) => ChatNotifier()),
        ChangeNotifierProvider(create: (_) => MenuNotifier()),
        ChangeNotifierProvider(create: (_) => EditNotifier()),
      ],
      child: MaterialApp(
        title: 'Social Flow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
