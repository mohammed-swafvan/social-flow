import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/firestore_services.dart';
import 'package:social_flow/services/storage_services.dart';

class EditNotifier extends ChangeNotifier {
  bool isLoading = false;
  Uint8List? file;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? userStream;

  getUserStream() async {
    userStream = FirestoreServices().getUserStream();
    notifyListeners();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  despostControllers() {
    file = null;
    usernameController.clear();
    nameController.clear();
    categoryController.clear();
    bioController.clear();
    notifyListeners();
  }

  Future<void> updateUserData({
    required BuildContext context,
    required String photoUrl,
    required String username,
    required String name,
    required String category,
    required String bio,
  }) async {
    if (file == null &&
        usernameController.text.isEmpty &&
        nameController.text.isEmpty &&
        categoryController.text.isEmpty &&
        bioController.text.isEmpty) {
      Utils().customSnackBar(context: context, content: "Edit any user data");
    } else {
      isLoading = true;
      notifyListeners();

      String updatedImage = '';

      if (file != null) {
        updatedImage = await StorageServices().uploadImageToStorage(file: file!, imageTypeName: 'prof', isPost: false);
      } else {
        updatedImage = photoUrl;
      }

      String result = await FirestoreServices().updateUserDetails(
        username: username,
        updatedProf: updatedImage,
        name: name,
        category: category,
        bio: bio,
      );

      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        Utils().customSnackBar(context: context, content: result);
      }
    }
  }

  Future<void> updataProfilePhoto({required BuildContext context}) async {
    final bool ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios ? openAddProfileActionSheet(ctx: context) : openAddProfileBottomSheet(ctx: context);
  }

  ///// BOTTOM SHEET
  openAddProfileBottomSheet({required BuildContext ctx}) {
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
                        file = imageFile;
                        notifyListeners();
                      } else {
                        Uint8List? imageFile = await Utils().pickImage(context: ctx, imageSource: ImageSource.camera);
                        file = imageFile;
                        notifyListeners();
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

  ///// ACTION SHEET
  Future<void> openAddProfileActionSheet({required BuildContext ctx}) {
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
                    file = imageFile;
                    notifyListeners();
                  } else {
                    Uint8List? imageFile = await Utils().pickImage(context: ctx, imageSource: ImageSource.camera);
                    file = imageFile;
                    notifyListeners();
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
}
