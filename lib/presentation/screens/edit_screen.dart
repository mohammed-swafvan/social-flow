import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text_field_input.dart';
import 'package:social_flow/providers/edit_screen_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).getUser;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Consumer<EditScreenProvider>(builder: (context, value, _) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              value.disposeEveryThing();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kWhiteColor.withOpacity(0.7),
            ),
          );
        }),
        title: CustomTextWidget(
          name: "Edit",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: screenWidth,
        child: ListView(
          children: [
            kHeight20,
            Column(
              children: [
                Consumer<EditScreenProvider>(builder: (context, value, _) {
                  return Stack(
                    children: [
                      value.image == null
                          ? Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(70)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    user!.photoUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(70)),
                                image: DecorationImage(
                                  image: MemoryImage(
                                    value.image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            value.selectImage();
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: kMainColor.withOpacity(0.7),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            kHeight30,
            Consumer<EditScreenProvider>(
              builder: (context, value, _) {
                return TextFieldWidget(
                  textEdingController: value.usernameController,
                  hintText: user!.username,
                  labelText: 'username',
                  textInputType: TextInputType.name,
                );
              },
            ),
            kHeight15,
            Consumer<EditScreenProvider>(
              builder: (context, value, _) {
                return TextFieldWidget(
                  textEdingController: value.nameController,
                  hintText: user!.name.isNotEmpty ? user.name : 'add name',
                  labelText: 'name',
                  textInputType: TextInputType.name,
                );
              },
            ),
            kHeight15,
            Consumer<EditScreenProvider>(
              builder: (context, value, _) {
                return TextFieldWidget(
                  textEdingController: value.categoryController,
                  hintText: user!.category.isNotEmpty ? user.category : 'add category',
                  labelText: 'category',
                  textInputType: TextInputType.text,
                );
              },
            ),
            kHeight15,
            Consumer<EditScreenProvider>(
              builder: (context, value, _) {
                return TextFieldWidget(
                  textEdingController: value.bioController,
                  hintText: user!.bio.isNotEmpty ? user.bio : 'add bio',
                  labelText: 'bio',
                  textInputType: TextInputType.name,
                );
              },
            ),
            kHeight30,
            Consumer<EditScreenProvider>(builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  onTap: () async {
                    await value.updateButtonClick(
                      context: context,
                      photoUrl: user!.photoUrl,
                      email: user.email,
                      username: value.usernameController.text.isEmpty ? user.username : value.usernameController.text,
                      name: value.nameController.text.isEmpty ? user.name : value.nameController.text,
                      category: value.categoryController.text.isEmpty ? user.category : value.categoryController.text,
                      bio: value.bioController.text.isEmpty ? user.bio : value.bioController.text,
                      uid: user.uid,
                      followers: user.followers,
                      following: user.following,
                    );
                    value.disposeEveryThing();
                  },
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
                    child: CustomTextWidget(
                      name: "Update",
                      size: 18,
                      fontWeight: FontWeight.w500,
                      textColor: kWhiteColor,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
