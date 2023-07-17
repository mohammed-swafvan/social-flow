import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class AddPostProvider extends ChangeNotifier {
  Uint8List? file;
  TextEditingController decriptionController = TextEditingController();
  bool isLoading = false;

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: kMainColor.withOpacity(0.4),
          title: CustomTextWidget(
            name: "Create a post",
            size: 18,
            fontWeight: FontWeight.bold,
            textColor: kWhiteColor,
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomTextWidget(
                name: "Take a photo",
                size: 16,
                fontWeight: FontWeight.w500,
                textColor: kYellowColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imgFile = await pickImage(ImageSource.camera);
                file = imgFile;
                notifyListeners();
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: CustomTextWidget(
                name: "Choose from gallery",
                size: 16,
                fontWeight: FontWeight.w500,
                textColor: kYellowColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imgFile = await pickImage(ImageSource.gallery);
                file = imgFile;
                notifyListeners();
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(width: 1, color: kWhiteColor)),
                child: CustomTextWidget(
                  name: "Cancel",
                  size: 16,
                  fontWeight: FontWeight.bold,
                  textColor: kWhiteColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> postImage(
      {required String uid, required String username, required String profImage, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      String res = await FirestoreMethods().uploadPost(
        decriptionController.text,
        file!,
        uid,
        username,
        profImage,
      );

      if (res == "success") {
        isLoading = false;

        // ignore: use_build_context_synchronously
        showSnackbar("Posted", context);
        clearImage();
        notifyListeners();
      } else {
        isLoading = false;

        // ignore: use_build_context_synchronously
        showSnackbar(res, context);
        notifyListeners();
      }
    } catch (error) {
      showSnackbar(error.toString(), context);
      notifyListeners();
    }
  }

  void disposeController() {
    decriptionController.clear();
    notifyListeners();
  }

  clearImage() {
    file = null;
  }
}
