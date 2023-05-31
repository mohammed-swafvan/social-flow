// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

ThemeData themeData() {
  return ThemeData(
    primaryColor: kMainColor,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: GoogleFonts.kalam().fontFamily,
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

BottomNavigationBarItem bottomNavItems({required IconData navIcon, required int currentPage, required int page}) {
  return BottomNavigationBarItem(
    icon: Icon(
      navIcon,
      size: currentPage == page ? 32 : 28,
    ),
  );
}

TextStyle customTextStyle(Color textColor, double size, FontWeight fontWeight) {
  return GoogleFonts.kalam(
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

Container customLine(screenWidth) {
  return Container(
    height: 2,
    width: screenWidth * 0.38,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: kMainColor,
    ),
  );
}

Future postCardDialogue(bool isHomepage, snap, ctx) async {
  showDialog(
    context: ctx,
    builder: (ctx1) => Dialog(
      backgroundColor: kSmallContextsColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              if (!isHomepage) {
                FirestoreMethods().deletePost(snap['postId'], ctx);
                Navigator.of(ctx1).pop();
                Navigator.of(ctx).pop();
                Provider.of<ProfileScreenProvider>(ctx, listen: false).getData(ctx);
              } else {}
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: isHomepage
                  ? CustomTextWidget(
                      name: "follow",
                      textColor: kMainColor,
                      fontWeight: FontWeight.w500,
                      size: 18,
                    )
                  : CustomTextWidget(
                      name: "Delete",
                      textColor: kRedColor,
                      fontWeight: FontWeight.w500,
                      size: 18,
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}
