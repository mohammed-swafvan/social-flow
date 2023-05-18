import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_flow/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

///////////////// signup user //////////////////////

  Future<String> singnUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (username.isEmpty) {
        res = "Please enter your user name";
      } else if (email.isEmpty) {
        res = "Please enter your email";
      } else if (password.isEmpty) {
        res = "Please enter your password";
      } else if (bio.isEmpty) {
        res = "Please enter your bio";
      }

      if (email.isNotEmpty || username.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || file != null) {
        // register user
        final UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);

        log("uid : ${cred.user!.uid}");

        String photoUrl = await StorageMethods().uploadImageToStorage('ProfilePic', file, false);

        // add user to our database
        await firestore.collection("users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        res = "success";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        res = "The email address is baddly formated";
      } else if (error.code == 'weak-password') {
        res = "Password should be atleast 6 characters";
      }
      if (error.code == 'eamil-already-in-use') {
        res = "This email is already exist";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  ///////////////// login user //////////////////////

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Incorrect email or password";
    try {
      if (email.isEmpty) {
        res = "Enter your email";
      } else if (password.isEmpty) {
        res = "enter your password";
      }

      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } 
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        res = "This user doesn't exist";
      } else if (error.code == 'invalid-email') {
        res = 'Enter your email properly';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
