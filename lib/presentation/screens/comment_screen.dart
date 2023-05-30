import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/comment_card_widget.dart';
import 'package:social_flow/presentation/widgets/text.dart';
import 'package:social_flow/providers/user_provider.dart';
import 'package:social_flow/resources/firestore_methods.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.snap});

  final Map snap;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: kWhiteColor.withOpacity(0.7),
          ),
        ),
        title: CustomTextWidget(
          name: "Comments",
          size: 24,
          fontWeight: FontWeight.bold,
          textColor: kYellowColor,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy(
              'datePublished',
              descending: true,
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressWidget());
          }

          return snapShot.data!.docs.isEmpty
              ? Center(
                  child: CustomTextWidget(
                    name: "No comments",
                    size: 18,
                    fontWeight: FontWeight.w500,
                    textColor: kWhiteColor,
                  ),
                )
              : ListView.builder(
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return CommentCartWidget(
                      snap: snapShot.data!.docs[index].data(),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            color: kWhiteColor.withOpacity(0.13),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 22,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: commentController,
                    style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Add a comment as ${user.username}',
                      hintStyle: customTextStyle(kWhiteColor.withOpacity(0.5), 16, FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await FirestoreMethods().postComment(
                    context,
                    widget.snap['postId'],
                    commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );
                  commentController.clear();
                },
                icon: Icon(
                  Icons.send,
                  color: kMainColor,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
