import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/screens/message_screen.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/presentation/widgets/post_card.dart';
import 'package:social_flow/provider/home_notifier.dart';
import 'package:social_flow/theme/socia_flow_logo.dart';
import 'package:social_flow/theme/custom_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeNotifier>(context, listen: false).getPostStream();
    });
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                SocialFlowLogo(
                  backGroundRadius: screenWidth / 10,
                  textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 18,
                        color: CustomColors.socialFlowLabelColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSize.width10,
                Text(
                  "Social Flow",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.socialFlowLabelColor,
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessageScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.message_outlined,
                    size: 30,
                    color: CustomColors.socialFlowLabelColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Consumer<HomeNotifier>(builder: (context, notifier, _) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      notifier.getPostStream();
                    },
                    child: StreamBuilder(
                        stream: notifier.postStream,
                        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting || notifier.postStream == null) {
                            return const Center(
                              child: GradientCircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'No Posts',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? CustomColors.lightModeDescriptionColor
                                          : CustomColors.darkModeDescriptionColor,
                                    ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = snapshot.data!.docs[index].data();
                              return PostCard(postData: data);
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        }),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
