import 'package:flutter/material.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/search_screen_widgets/search_idle_widget.dart';
import 'package:social_flow/presentation/widgets/search_screen_widgets/search_result_widget.dart';

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
                    size: 26,
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
          searchController.text.isEmpty ? const SearchIdleWidget() : const SearchResultWidget(),
        ],
      ),
    ));
  }
}
