import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_flow/presentation/screens/login_screen.dart';
import 'package:social_flow/presentation/screens/single_post_screen.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/my_delagate_widget.dart';
import 'package:social_flow/presentation/widgets/profile_view_widget.dart';
import 'package:social_flow/presentation/widgets/text.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: kBackgroundColor,
              title: CustomTextWidget(
                name: userData['username'],
                size: 24,
                fontWeight: FontWeight.bold,
                textColor: kYellowColor,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  icon: const Icon(
                    Icons.dehaze,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: kBackgroundColor,
                      collapsedHeight: screenHeight * 0.24,
                      expandedHeight: screenHeight * 0.24,
                      flexibleSpace: ProfileViewWidget(
                        userDetails: userData,
                        postLength: postLength,
                      ),
                    ),
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: MyDelagatWidget(
                        tabBar: TabBar(
                          indicatorColor: kWhiteColor,
                          unselectedLabelColor: kWhiteColor.withOpacity(0.5),
                          labelColor: kWhiteColor,
                          tabs: const [Tab(icon: Icon(Icons.grid_on)), Tab(icon: Icon(Icons.bookmark))],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    FutureBuilder(
                        future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).get(),
                        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) {
                          if (snapShot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap = snapShot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SinglePostScreen(
                                        snap: snap.data(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snap['postUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: snapShot.data!.docs.length,
                          );
                        }),
                    Container(),
                  ],
                ),
              ),
            ),
          );
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
      userData = userSnap.data()!;

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;

      setState(() {});
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }
}
