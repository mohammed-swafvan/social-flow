// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/screens/splash_screen.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snapShot = await firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnapShot(snapShot);
  }

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

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

      // ignore: unnecessary_null_comparison
      if (email.isNotEmpty || username.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || file != null) {
        final UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);

        log("uid : ${cred.user!.uid}");

        String photoUrl = await StorageMethods().uploadImageToStorage('ProfilePic', file, false);

        UserModel userModel = UserModel(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
          name: "",
          category: "",
        );

        await firestore.collection("users").doc(cred.user!.uid).set(userModel.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        res = "The email address is baddly formated";
      } else if (error.code == 'weak-password') {
        res = "Password should be atleast 6 characters";
      } else if (error.code == 'email-already-in-use') {
        res = "This email is already exist";
      }
    } catch (err) {
      log(err.toString());
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Incorrect email or password";
    try {
      if (email.isEmpty && password.isEmpty) {
        res = "Enter your email and password";
      } else if (email.isEmpty) {
        res = "enter your email";
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
      } else if (error.code == 'invalid-password') {
        res = 'Enter your password properly';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;
    if (context.mounted) {}
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        log(e.toString());
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);

          user = userCredential.user;
          UserModel userModel = UserModel(
            email: userCredential.user!.email!,
            uid: userCredential.user!.uid,
            photoUrl: user!.photoURL!,
            username: userCredential.user!.displayName!,
            followers: [],
            following: [],
            bio: "",
            name: "",
            category: "",
          );
          if (userCredential.additionalUserInfo!.isNewUser) {
            firestore.collection("users").doc(userCredential.user!.uid).set(userModel.toJson());
          }
        } on FirebaseAuthException catch (e) {
          if (context.mounted) {}
          if (e.code == 'account-exists-with-different-credential') {
            showSnackbar('The account already exists with a different credential.', context);
          } else if (e.code == 'invalid-credential') {
            showSnackbar('Error occurred while accessing credentials. Try again.', context);
          }
        } catch (e) {
          if (context.mounted) {}
          showSnackbar('Error occurred using Google Sign-In. Try again.', context);
        }
      } else {
        log("account is doesn't exist");
      }
    }

    return user;
  }

  

  Future<void> logOutUser(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
        await auth.signOut();
      }
      await FirebaseAuth.instance.signOut();
      await auth.signOut();

      if (context.mounted) {}
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Main(),
        ),
        (context) => false,
      );
    } catch (e) {
      log(e.toString());
      showSnackbar(e.toString(), context);
    }
  }
  String getUserUid() {
    User user = auth.currentUser!;
    return user.uid;
  }
}
