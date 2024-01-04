import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/create_post_notifier.dart';

import '../../services/firestore_services.dart';

class AdaptiveMaterial {
  //// CREATE POST BOTTOM SHEET
  static openAddPostBottomSheet({required BuildContext context}) {
    List<String> items = ["Choose from library", "Take photo"];
    List<IconData> icons = [Icons.photo_library_rounded, Icons.camera_enhance_rounded];
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Consumer<CreatePostNotifier>(
            builder: (context, notifier, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(
                    items.length,
                    (index) => Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
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
                        icon: Icon(icons[index]),
                        label: Text(items[index]),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  //// Dailog Box
  static openMaterialDialog(
      {required BuildContext context, required Function() onTap, required String title, required String content}) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  ),
            ),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onTap,
                child: const Text(
                  'OK',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }

  //// ADD PROFILE BOTTOM SHEET
  static openAddProfileBottomSheet({required BuildContext ctx}) {
    List<String> items = ["Choose from library", "Take photo"];
    List<IconData> icons = [Icons.photo_library_rounded, Icons.camera_enhance_rounded];
    return showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(
                items.length,
                (index) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
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
                    icon: Icon(icons[index]),
                    label: Text(items[index]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ////// DELETE POST BOTTOM SHEET
  static openDeletePostBottomSheet({required BuildContext context, required Function() onTap}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text("Cancel"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
