import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_flow/models/user_model.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getUserId() {
    User user = auth.currentUser!;
    String userId = user.uid;
    return userId;
  }

  Future<UserModel> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snapShot = await firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnapShot(snapShot);
  }

  Future<String> userRegistration({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (username.isEmpty) {
        res = "Please enter your user name";
        return res;
      } else if (email.isEmpty) {
        res = "Please enter your email";
        return res;
      } else if (password.isEmpty) {
        res = "Please enter your password";
        return res;
      }

      final UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
        email: email,
        uid: cred.user!.uid,
        photoUrl:
            "https://static.vecteezy.com/system/resources/thumbnails/024/095/208/small/happy-young-man-smiling-free-png.png",
        username: username,
        bio: "",
        followers: [],
        following: [],
        name: "",
        category: "",
      );

      await firestore.collection("users").doc(cred.user!.uid).set(userModel.toJson());

      res = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        res = "The email address is baddly formated";
      } else if (error.code == 'weak-password') {
        res = "Password should be atleast 6 characters";
      } else if (error.code == 'email-already-in-use') {
        res = "This email is already exist";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> userLogin({required String email, required String password}) async {
    String res = "Incorrect email or password";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "This user doesn't exist";
      } else if (e.code == 'wrong-password') {
        res = 'Pass is incorrect';
      } else if (e.code == 'invalid-email') {
        res = 'Enter your email properly';
      } else if (e.code == 'invalid-credential') {
        res = "Email or Password something went wrong";
      } else {
        res = e.code;
      }
    }
    return res;
  }

  Future<void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
    await auth.signOut();
  }

  Future<String> resetPassword({required String email}) async {
    String result = 'Something went wrong';
    try {
      await auth.sendPasswordResetEmail(email: email);
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = "No user found for that email";
      } else {
        result = e.code;
      }
    }
    return result;
  }

  bool isCurrentUser({required String uid}) {
    String currentUid = getUserId();
    if (currentUid == uid) {
      return true;
    } else {
      return false;
    }
  }
}
