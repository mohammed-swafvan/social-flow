import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

class StorageServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage({required Uint8List file, required String imageTypeName, required bool isPost}) async {
    Reference ref = storage.ref().child(imageTypeName).child(auth.currentUser!.uid);
    if (isPost) {
      String id = randomAlphaNumeric(12);
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
