// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/providers/user_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';
import 'package:social_flow/resources/storage_method.dart';

class EditScreenProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  Uint8List? image;
  bool isLoading = false;

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    image = img;
    notifyListeners();
  }

  updateButtonClick({
    required BuildContext context,
    required String photoUrl,
    required String email,
    required String username,
    required String name,
    required String category,
    required String bio,
    required String uid,
    required List followers,
    required List following,
  }) async {
    if (image == null &&
        usernameController.text.isEmpty &&
        nameController.text.isEmpty &&
        categoryController.text.isEmpty &&
        bioController.text.isEmpty) {
      showSnackbar("edit any field", context);
    } else {
      isLoading = true;
      notifyListeners();
      String res = "Some error occured";
      if (image == null) {
        res = await FirestoreMethods().updateUserDetails(
          photoUrl: photoUrl,
          email: email,
          username: username,
          name: name,
          category: category,
          bio: bio,
          uid: uid,
          followers: followers,
          following: following,
        );
      } else {
        String photo = await StorageMethods().uploadImageToStorage('ProfilePic', image!, false);
        res = await FirestoreMethods().updateUserDetails(
          photoUrl: photo,
          email: email,
          username: username,
          name: name,
          category: category,
          bio: bio,
          uid: uid,
          followers: followers,
          following: following,
        );
      }

      if (res != "updated") {
        isLoading = false;
        notifyListeners();
        showSnackbar(res, context);
      } else {
        isLoading = false;
        notifyListeners();
        disposeEveryThing();
        Navigator.of(context).pop();
        showSnackbar(res, context);
        await Provider.of<UserProvider>(context, listen: false).refreshUser();
      }
    }

    notifyListeners();
  }

  disposeEveryThing() {
    usernameController.clear();
    nameController.clear();
    categoryController.clear();
    bioController.clear();
    image = null;
  }
}
