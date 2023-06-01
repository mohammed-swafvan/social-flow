import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          kHeight10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: kWhiteColor.withOpacity(0.13),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              height: screenHeight * 0.06,
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: kWhiteColor.withOpacity(0.7),
                    size: 28,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: searchController,
                        style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'search for users',
                          hintStyle: customTextStyle(kWhiteColor.withOpacity(0.5), 16, FontWeight.w500),
                          border: InputBorder.none,
                        ),
                        onChanged: (String value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          searchController.text.isEmpty
              ? MasonryGridView.count(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemCount: dummyImages.length,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: index % 5 == 0 || index % 4 == 0 ? 250 : 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(dummyImages[index]), fit: BoxFit.cover),
                      ),
                    );
                  },
                  crossAxisCount: 2,
                )
              : ListView.separated(
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ListTile(
                        minVerticalPadding: 20,
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/my_prof_pic.jpg'),
                        ),
                        title: CustomTextWidget(
                          name: 'user name',
                          size: 18,
                          fontWeight: FontWeight.w500,
                          textColor: kWhiteColor,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: kWhiteColor.withOpacity(0.3),
                        thickness: 1,
                      ),
                    );
                  },
                  itemCount: 20),
        ],
      ),
    ));
  }

  List<String> dummyImages = [
    "https://media.gettyimages.com/id/962792890/photo/real-madrid-v-liverpool-uefa-champions-league-final.jpg?s=1024x1024&w=gi&k=20&c=gmwsJbCnX2yFMTab3W9UY2UqnecLRkDfu2pmYO9_3vk=",
    "https://images.pexels.com/photos/247929/pexels-photo-247929.jpeg?cs=srgb&dl=pexels-pixabay-247929.jpg&fm=jpg",
    "https://images.pexels.com/photos/1414535/pexels-photo-1414535.jpeg?cs=srgb&dl=pexels-connor-danylenko-1414535.jpg&fm=jpg",
    "https://images.pexels.com/photos/103286/pexels-photo-103286.jpeg?cs=srgb&dl=pexels-markus-spiske-103286.jpg&fm=jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5J4xfniuAmLktwNo4XG8ml83hahSXFH1R4A&usqp=CAU",
    "https://img.cutenesscdn.com/-/cme-data/getty/d0a66ba562b44728b22a0a903341afd2.jpg",
    "https://c4.wallpaperflare.com/wallpaper/179/427/668/cristiano-ronaldo-4k-hd-pc-download-wallpaper-preview.jpg",
    "https://images.pexels.com/photos/247929/pexels-photo-247929.jpeg?cs=srgb&dl=pexels-pixabay-247929.jpg&fm=jpg",
    "https://images.pexels.com/photos/459449/pexels-photo-459449.jpeg?cs=srgb&dl=pexels-pixabay-459449.jpg&fm=jpg",
  ];
}
