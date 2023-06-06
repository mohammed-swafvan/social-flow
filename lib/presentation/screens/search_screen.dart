import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/presentation/utils/global_variables.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/presentation/widgets/search_screen_widgets/search_idle_widget.dart';
import 'package:social_flow/presentation/widgets/search_screen_widgets/search_result_widget.dart';
import 'package:social_flow/providers/search_screen_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
              height: screenHeight * 0.065,
              padding: const EdgeInsets.only(left: 12, right: 6),
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
                      padding: const EdgeInsets.only(left: 10.0, right: 8),
                      child: Consumer<SearchScreenProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: value.searchController,
                            style: customTextStyle(kWhiteColor, 16, FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'search for users',
                              hintStyle: customTextStyle(kWhiteColor.withOpacity(0.5), 16, FontWeight.w500),
                              border: InputBorder.none,
                            ),
                            onChanged: (String searchedValue) {
                              if (searchedValue.isEmpty) {
                                value.hideUser();
                              } else {
                                value.showUser();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Consumer<SearchScreenProvider>(builder: (context, value, _) {
                    return IconButton(
                      onPressed: () {
                        value.disposeSearchController();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: kWhiteColor.withOpacity(0.7),
                        size: 18,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Consumer<SearchScreenProvider>(
            builder: (context, value, _) {
              return value.isShowUser ? const SearchResultWidget() : const SearchIdleWidget();
            },
          ),
        ],
      ),
    ));
  }
}
