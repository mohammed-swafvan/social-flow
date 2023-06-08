// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/profile_screen_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

//////// Theme Data//////////
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

////// image picking from camera or gallery ///////
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }

  log("No Image Selected");
}

/////// snack bar ////////
showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kSmallContextsColor,
      content: CustomTextWidget(
        name: content,
        size: 16,
        fontWeight: FontWeight.w600,
        textColor: kYellowColor,
      ),
    ),
  );
}

/////// bottom navigation bar items ////////
BottomNavigationBarItem bottomNavItems({required IconData navIcon, required int currentPage, required int page}) {
  return BottomNavigationBarItem(
    icon: Icon(
      navIcon,
      size: currentPage == page ? 32 : 28,
    ),
  );
}

/////// text style /////////
TextStyle customTextStyle(Color textColor, double size, FontWeight fontWeight) {
  return GoogleFonts.kalam(
    textStyle: TextStyle(
      color: textColor,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

/////// column for user profile header section ///////
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

//////// line for login and signup screen ////////
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

//////// post deleting dialogue box ///////////
Future deleteDialogue({required snap, required ctx, required isPost, postId}) async {
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
              if (isPost) {
                FirestoreMethods().deletePost(snap['postId'], ctx);
                Navigator.of(ctx1).pop();
                Provider.of<ProfileScreenProvider>(ctx, listen: false).getData(ctx, snap['uid']);
              } else {
                FirestoreMethods().deleteComment(ctx, postId, snap['commentId']);
                Navigator.of(ctx1).pop();
                Provider.of<ProfileScreenProvider>(ctx, listen: false).getData(ctx, snap['uid']);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: CustomTextWidget(
                name: "Delete",
                textColor: kRedColor,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/////// other users more option dialogue ///////
Future otherUsersMoreDialogue(snap, ctx, isSinglePostScreen) async {
  isSave = await FirestoreMethods().isSavedCheking(snap['postId']);
  if (!isSinglePostScreen) {
    isFollow = await FirestoreMethods().isFollowChecking(snap['uid']);
  }
  showDialog(
    context: ctx,
    builder: (ctx1) => Dialog(
      backgroundColor: kWhiteColor.withOpacity(0.8),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        children: [
          isSinglePostScreen
              ? const SizedBox()
              : InkWell(
                  onTap: () async {
                    Navigator.of(ctx1).pop();
                    await FirestoreMethods().followUser(
                      context: ctx,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      followId: snap['uid'],
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: isFollow
                          ? CustomTextWidget(
                              name: "unfollow",
                              textColor: kMainColor,
                              fontWeight: FontWeight.bold,
                              size: 20,
                            )
                          : CustomTextWidget(
                              name: "follow",
                              textColor: kMainColor,
                              fontWeight: FontWeight.bold,
                              size: 20,
                            )),
                ),
          InkWell(
            onTap: () async {
              Navigator.of(ctx1).pop();

              await FirestoreMethods().savePost(
                ctx,
                snap['postId'],
                snap['username'],
                FirebaseAuth.instance.currentUser!.uid,
                snap['datePublished'],
                snap['postUrl'],
                snap['description'],
                snap['likes'],
              );

              if (isSinglePostScreen) {
                Navigator.of(ctx).pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: CustomTextWidget(
                name: isSave ? "unsave" : "save",
                textColor: kMainColor,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
