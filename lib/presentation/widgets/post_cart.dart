import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/text.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.snap});

  final Map<String, dynamic> snap;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ////// Header section ////////
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          name: snap['username'],
                          size: 18,
                          fontWeight: FontWeight.w400,
                          textColor: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: kSmallContextsColor,
                        child: ListView(padding: const EdgeInsets.symmetric(vertical: 16), shrinkWrap: true, children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: CustomTextWidget(
                                name: "Delete",
                                textColor: kRedColor,
                                fontWeight: FontWeight.w500,
                                size: 18,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: kWhiteColor.withOpacity(0.7),
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),

          /////// Image section //////
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.47,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          //////// Like Comment and save section /////////
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: kWhiteColor.withOpacity(0.7),
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                  color: kWhiteColor.withOpacity(0.7),
                  size: 28,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_border,
                      color: kWhiteColor.withOpacity(0.7),
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
          ),

          //////// desribtion and number of cmnts section ///////
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  name: "${snap['likes'].length} likes",
                  size: 14,
                  fontWeight: FontWeight.normal,
                  textColor: kWhiteColor.withOpacity(0.8),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(style: customTextStyle(kWhiteColor, 16, FontWeight.bold), children: [
                      TextSpan(
                        text: snap['username'],
                      ),
                      TextSpan(
                        text: '  ${snap['description']}',
                        style: customTextStyle(kWhiteColor.withOpacity(0.7), 15, FontWeight.w500),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: CustomTextWidget(
                name: "view all 200 comments",
                size: 14,
                fontWeight: FontWeight.w200,
                textColor: kWhiteColor.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomTextWidget(
              name: DateFormat.yMEd().format(snap['datePublished'].toDate()),
              size: 12,
              fontWeight: FontWeight.w200,
              textColor: kWhiteColor.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
