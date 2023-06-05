import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/add_post_provider.dart';
import 'package:social_flow/providers/user_provider.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userDetails = Provider.of<UserProvider>(context).getUser;
    final provider = Provider.of<AddPostProvider>(context);

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return provider.file == null
        ? Consumer<AddPostProvider>(
            builder: (context, value, child) {
              return Center(
                child: InkWell(
                  onTap: () => value.selectImage(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: kYellowColor.withOpacity(0.7),
                        size: 40,
                      ),
                      kHeight10,
                      CustomTextWidget(
                        name: "Add Post",
                        size: 18,
                        fontWeight: FontWeight.bold,
                        textColor: kYellowColor.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              leading: Consumer<AddPostProvider>(
                builder: (context, value, child) {
                  return IconButton(
                    onPressed: () {
                      value.clearImage();
                      value.disposeController();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: kWhiteColor.withOpacity(0.7),
                    ),
                  );
                },
              ),
              title: CustomTextWidget(
                name: "New Post",
                size: 24,
                fontWeight: FontWeight.bold,
                textColor: kYellowColor,
              ),
            ),
            body: Consumer<AddPostProvider>(
              builder: (context, value, child) {
                return ListView(
                  children: [
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(userDetails!.photoUrl),
                        ),
                        Container(
                          height: screenHeight * 0.45,
                          width: screenWidth * 0.75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(value.file!),
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHeight20,
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
                                controller: value.decriptionController,
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
                          ),
                        ],
                      ),
                    ),
                    kHeight30,
                    kHeight20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: InkWell(
                        onTap: () async {
                          await value.postImage(
                            uid: userDetails.uid,
                            username: userDetails.username,
                            profImage: userDetails.photoUrl,
                            context: context,
                          );
                          value.disposeController();
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: ShapeDecoration(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            color: kMainColor,
                          ),
                          child: value.isLoading
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
                );
              },
            ),
          );
  }
}
