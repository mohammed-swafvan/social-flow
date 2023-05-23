import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/text.dart';

ThemeData themeData() {
  return ThemeData(
    primaryColor: kMainColor,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: GoogleFonts.irishGrover().fontFamily,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: kWhiteColor,
      ),
      bodySmall: TextStyle(color: kWhiteColor),
      bodyMedium: TextStyle(color: kWhiteColor),
    ),
  );
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }

  log("No Image Selected");
}

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

BottomNavigationBarItem bottomNavItems({required IconData navIcon, required int currentPage, required int pages}) {
  return BottomNavigationBarItem(
    icon: Icon(
      navIcon,
      color: pages == currentPage ? kMainColor : kMainColor.withOpacity(0.6),
      size: pages == currentPage ? 36 : 32,
    ),
  );
}

TextStyle customTextStyle(Color textColor, double size, FontWeight fontWeight) {
  return GoogleFonts.irishGrover(
    textStyle: TextStyle(
      color: textColor,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Column customStatColumn(String number, String item) {
  return Column(
    children: [
      CustomTextWidget(
        name: number,
        size: 18,
        fontWeight: FontWeight.bold,
        textColor: kWhiteColor,
      ),
      CustomTextWidget(
        name: item,
        size: 12,
        fontWeight: FontWeight.w400,
        textColor: kWhiteColor,
      ),
    ],
  );
}
