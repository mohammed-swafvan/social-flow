import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/profile_screen.dart';
import 'package:social_flow/presentation/screens/add_post_screen.dart';
import 'package:social_flow/presentation/screens/home_screen.dart';
import 'package:social_flow/presentation/screens/search_screen.dart';

Widget kHeight10 = const SizedBox(height: 10);
Widget kHeight20 = const SizedBox(height: 20);
Widget kHeight30 = const SizedBox(height: 30);
Widget kHeight15 = const SizedBox(height: 15);
const webSreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const ProfileScreen(),
];
