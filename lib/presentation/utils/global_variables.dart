import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/add_post_screen/add_post_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';

Widget kSizedBox10 = const SizedBox(height: 10);
Widget kSizedBox20 = const SizedBox(height: 20);
Widget kSizedBox30 = const SizedBox(height: 30);
Widget kSizedBox15 = const SizedBox(height: 15);
const webSreenSize = 600;

List<Widget> homeScreenItems = [
  Text(
    "Home",
    style: TextStyle(color: kWhiteColor),
  ),
  Text(
    "search",
    style: TextStyle(color: kWhiteColor),
  ),
  const AddPostScreen(),
  Text(
    "account",
    style: TextStyle(color: kWhiteColor),
  ),
];


