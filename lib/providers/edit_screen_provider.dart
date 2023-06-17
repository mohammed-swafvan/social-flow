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
    String res = "Some error occured";
    if (image == null) {
      res = FirestoreMethods().updateUserDetails(
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
      res = FirestoreMethods().updateUserDetails(
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
      showSnackbar(res, context);
      notifyListeners();
    } else {
      Navigator.of(context).pop();
      await Provider.of<UserProvider>(context, listen: false).refreshUser();
      showSnackbar(res, context);
      notifyListeners();
    }
  }

  disposeEveryThing() {
    usernameController.clear();
    nameController.clear();
    categoryController.clear();
    bioController.clear();
    image = null;
  }
}
