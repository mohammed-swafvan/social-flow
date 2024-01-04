import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/create_post_notifier.dart';
import 'package:social_flow/services/firestore_services.dart';

class AdaptiveCupertino {

  //// CREATE POST ACTION SHEET
  static openAddPostActionSheet({required BuildContext context}) {
    List<String> items = ["Choose from library", "Take photo"];
    List<IconData> icons = [Icons.photo_library_rounded, Icons.camera_enhance_rounded];
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Consumer<CreatePostNotifier>(
          builder: (context, notifier, _) {
            return CupertinoActionSheet(
              actions: [
                ...List.generate(
                  items.length,
                  (index) => CupertinoActionSheetAction(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (index == 0) {
                        Uint8List? imageFile = await Utils().pickImage(context: context, imageSource: ImageSource.gallery);
                        notifier.imageFile = imageFile;
                      } else {
                        Uint8List? imageFile = await Utils().pickImage(context: context, imageSource: ImageSource.camera);
                        notifier.imageFile = imageFile;
                      }
                    },
                    child: Row(
                      children: [
                        Icon(icons[index]),
                        CustomSize.width15,
                        Text(items[index]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


  /// Dailog Box
  static openCupertinoDialog(
      {required BuildContext context, required Function() onTap, required String title, required String content}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                onPressed: onTap,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  //// ADD PROFILE ACTION SHEET
  static Future<void> openAddProfileActionSheet({required BuildContext ctx}) {
    List<String> items = ["Choose from library", "Take photo"];
    List<IconData> icons = [Icons.photo_library_rounded, Icons.camera_enhance_rounded];
    return showCupertinoModalPopup(
      context: ctx,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            ...List.generate(
              items.length,
              (index) => CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.of(context).pop();

                  if (index == 0) {
                    Uint8List? imageFile = await Utils().pickImage(context: ctx, imageSource: ImageSource.gallery);
                    if (ctx.mounted) {
                      FirestoreServices().updateProfilePhoto(context: ctx, file: imageFile!);
                    }
                  } else {
                    Uint8List? imageFile = await Utils().pickImage(context: ctx, imageSource: ImageSource.camera);
                    if (ctx.mounted) {
                      FirestoreServices().updateProfilePhoto(context: ctx, file: imageFile!);
                    }
                  }
                },
                child: Row(
                  children: [
                    Icon(icons[index]),
                    CustomSize.width15,
                    Text(items[index]),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ////// DELETE POST ACTION SHEET
  static openDeletePostActionSheet({required BuildContext context, required Function() onTap}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  CustomSize.width15,
                  Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Row(
                children: [
                  Icon(Icons.cancel),
                  CustomSize.width15,
                  Text("Cancel"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
