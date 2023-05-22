import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/user_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? file;
  TextEditingController decriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    decriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userDetails = Provider.of<UserProvider>(context).getUser;

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return file == null
        ? Center(
            child: IconButton(
              onPressed: () => selectImage(context),
              icon: Icon(
                Icons.upload,
                color: kYellowColor.withOpacity(0.6),
                size: 40,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kWhiteColor.withOpacity(0.7),
                ),
              ),
              title: CustomTextWidget(
                name: "New Post",
                size: 24,
                fontWeight: FontWeight.bold,
                textColor: kYellowColor,
              ),
            ),
            body: ListView(
              children: [
                kSizedBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userDetails.photoUrl),
                    ),
                    Container(
                      height: screenHeight * 0.45,
                      width: screenWidth * 0.75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(file!),
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                        ),
                      ),
                    )
                  ],
                ),
                kSizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: screenWidth * 0.75,
                        decoration: BoxDecoration(
                          color: kWhiteColor.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: TextField(
                            controller: decriptionController,
                            style: customTextStyle(kWhiteColor, 16, FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: "Write a caption",
                              hintStyle: customTextStyle(
                                kWhiteColor.withOpacity(0.7),
                                16,
                                FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: 5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                kSizedBox30,
                kSizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: () => postImage(
                      uid: userDetails.uid,
                      username: userDetails.username,
                      profImage: userDetails.photoUrl,
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: kMainColor,
                      ),
                      child: isLoading
                          ? const CircularProgressWidget()
                          : CustomTextWidget(
                              name: "Post",
                              size: 18,
                              fontWeight: FontWeight.w500,
                              textColor: kWhiteColor,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: kWhiteColor.withOpacity(0.2),
          title: CustomTextWidget(
            name: "Create a post",
            size: 18,
            fontWeight: FontWeight.w500,
            textColor: kWhiteColor,
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomTextWidget(
                name: "Take a photo",
                size: 16,
                fontWeight: FontWeight.w300,
                textColor: kMainColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imgFile = await pickImage(ImageSource.camera);
                setState(() {
                  file = imgFile;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: CustomTextWidget(
                name: "Choose from gallery",
                size: 16,
                fontWeight: FontWeight.w300,
                textColor: kMainColor,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imgFile = await pickImage(ImageSource.gallery);
                setState(() {
                  file = imgFile;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: CustomTextWidget(
                name: "Cancel",
                size: 16,
                fontWeight: FontWeight.w500,
                textColor: kWhiteColor,
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

  void postImage({required String uid, required String username, required String profImage}) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        decriptionController.text,
        file!,
        uid,
        username,
        profImage,
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackbar("Posted", context);
        clearImage();
      } else {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackbar(res, context);
      }
    } catch (error) {
      showSnackbar(error.toString(), context);
    }
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }
}
