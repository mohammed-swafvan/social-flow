import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/services/firestore_services.dart';

class CreatePostNotifier extends ChangeNotifier {
  bool isLoading = false;
  Uint8List? file;
  TextEditingController decriptionController = TextEditingController();

  Uint8List? get imageFile => file;

  set imageFile(Uint8List? fileImage) {
    file = fileImage;
    notifyListeners();
  }

  Future<void> uploadPost({
    required BuildContext context,
    required Uint8List postFile,
    required String username,
    required String profUrl,
    required String description,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      String result = await FirestoreServices().uploadPost(
        file: postFile,
        username: username,
        profUrl: profUrl,
        description: description,
      );

      if (result == "success") {
        file = null;
        decriptionController.clear();
        isLoading = false;
        notifyListeners();
        if (context.mounted) {
          return Utils().customSnackBar(context: context, content: "Post uploaded successfully");
        }
      } else {
        isLoading = false;
        notifyListeners();
        if (context.mounted) {
          return Utils().customSnackBar(context: context, content: result);
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: e.toString());
      }
    }
  }
}
