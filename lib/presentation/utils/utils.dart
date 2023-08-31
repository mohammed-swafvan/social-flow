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
import 'package:social_flow/resources/auth_methods.dart';
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
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: kMainColor.withOpacity(0.7),
      content: Container(
        alignment: Alignment.center,
        child: CustomTextWidget(
          name: content,
          size: 16,
          fontWeight: FontWeight.w600,
          textColor: kWhiteColor,
        ),
      ),
    ),
  );
}

/////// bottom navigation bar items ////////
BottomNavigationBarItem bottomNavItems({required IconData navIcon, required int currentPage, required int page}) {
  return BottomNavigationBarItem(
    icon: Icon(
      navIcon,
      size: currentPage == page ? 34 : 28,
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
Container customLine(width, color) {
  return Container(
    height: 2,
    width: width,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: color,
    ),
  );
}

//////// post deleting dialogue box ///////////
Future deleteDialogue({required snap, required bool isSinglePostScreen, required ctx, required isPost, postId}) async {
  showDialog(
    context: ctx,
    builder: (ctx1) => Dialog(
      backgroundColor: kMainColor.withOpacity(0.6),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              if (isPost) {
                if (isSinglePostScreen) {
                  FirestoreMethods().deletePost(snap['postId'], ctx);
                  Navigator.of(ctx1).pop();
                  Navigator.of(ctx).pop();
                  Provider.of<ProfileScreenProvider>(ctx, listen: false).getData(ctx, snap['uid']);
                } else {
                  FirestoreMethods().deletePost(snap['postId'], ctx);
                  Navigator.of(ctx1).pop();
                  Provider.of<ProfileScreenProvider>(ctx, listen: false).getData(ctx, snap['uid']);
                }
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
                      currentUserUid: FirebaseAuth.instance.currentUser!.uid,
                      followUserId: snap['uid'],
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

Future<void> showMyAlertDialog(BuildContext context, String username) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        titlePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        backgroundColor: kWhiteColor,
        title: CustomTextWidget(
          name: 'Log Out ?',
          size: 20,
          fontWeight: FontWeight.bold,
          textColor: kRedColor,
        ),
        content: CustomTextWidget(
          name: 'Are you sure $username. You want to Log out ?',
          size: 16,
          fontWeight: FontWeight.w500,
          textColor: kBackgroundColor,
        ),
        actions: [
          TextButton(
            child: CustomTextWidget(
              name: 'Cancel',
              size: 16,
              fontWeight: FontWeight.bold,
              textColor: kBackgroundColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: CustomTextWidget(
              name: 'Ok',
              size: 16,
              fontWeight: FontWeight.bold,
              textColor: kRedColor,
            ),
            onPressed: () async {
              await AuthMethods().logOutUser(context);
            },
          ),
        ],
      );
    },
  );
}

////// Delete message dialog
Future<void> deleteMessage({required BuildContext context, required String chatRoom, required String messageId}) async {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      backgroundColor: kDarkGrey,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      titlePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      title: CustomTextWidget(
        name: 'Delete Message',
        size: 20,
        fontWeight: FontWeight.bold,
        textColor: kWhiteColor,
      ),
      content: CustomTextWidget(
        name: 'Are you sure you want to delete this message',
        size: 16,
        fontWeight: FontWeight.w400,
        textColor: kWhiteColor.withOpacity(0.8),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: CustomTextWidget(
            name: 'Cancel',
            size: 14,
            fontWeight: FontWeight.w500,
            textColor: kWhiteColor.withOpacity(0.8),
          ),
        ),
        TextButton(
          onPressed: () async {
            await FirestoreMethods().deleteMessage(
              context: context,
              chatRoom: chatRoom,
              messageId: messageId,
            );
            Navigator.of(context).pop();
          },
          child: CustomTextWidget(
            name: 'OK',
            size: 14,
            fontWeight: FontWeight.bold,
            textColor: kWhiteColor,
          ),
        ),
      ],
    ),
  );
}
