import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/messanger_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/widgets/global_widgets/circular_progress.dart';
import 'package:social_flow/presentation/widgets/global_widgets/logo.dart';
import 'package:social_flow/presentation/widgets/post_card_widgets/post_card_widget.dart';
import 'package:social_flow/presentation/widgets/global_widgets/text.dart';
import 'package:social_flow/providers/search_screen_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<SearchScreenProvider>(context, listen: false).disposeSearchController();
    });
    return Scaffold(
      appBar: const MyAppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressWidget(),
            );
          }
          if (snapShot.hasError) {
            return Center(
              child: CustomTextWidget(
                name: "Some error occured",
                size: 18,
                fontWeight: FontWeight.w500,
                textColor: kWhiteColor,
              ),
            );
          }

          if (snapShot.data!.docs.isEmpty) {
            return Center(
              child: CustomTextWidget(
                name: "No posts",
                size: 18,
                fontWeight: FontWeight.w500,
                textColor: kWhiteColor,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapShot.data!.docs.length,
            itemBuilder: (context, index) => PostCardWidget(
              snap: snapShot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        leadingWidth: 45,
        backgroundColor: kBackgroundColor,
        leading: const SocilaFlowLogo(radius: 30),
        title: Row(
          children: [
            CustomTextWidget(
              name: "Social Flow",
              size: 24,
              fontWeight: FontWeight.bold,
              textColor: kYellowColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: kYellowColor,
              size: 30,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessangerScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.messenger_outline,
              color: kMainColor,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
