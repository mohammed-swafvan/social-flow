import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/provider/search_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchNotifier>(
        builder: (context, notifer, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: CustomColors.primaryLightColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: notifer.searchController,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomColors.socialFlowLabelColor,
                  ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w500, color: CustomColors.primaryLightColor),
                border: InputBorder.none,
              ),
              onChanged: (String searchedValue) {
                notifer.filterUsers();
                if (searchedValue.isEmpty) {
                  notifer.hideUsers = true;
                } else {
                  notifer.hideUsers = false;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
