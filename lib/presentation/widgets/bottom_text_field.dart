import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/models/user_model.dart';
import 'package:social_flow/presentation/utils/utils.dart';
import 'package:social_flow/provider/commet_notifier.dart';
import 'package:social_flow/theme/custom_colors.dart';

class BottomTextField extends StatelessWidget {
  const BottomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sendButtonPressed,
    required this.user,
    required this.isCommentTextField,
  });
  final TextEditingController controller;
  final VoidCallback sendButtonPressed;
  final String hintText;
  final UserModel user;
  final bool isCommentTextField;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isCommentTextField,
          replacement: const SizedBox.shrink(),
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SizedBox(
              width: 42,
              height: 42,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: user.photoUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Utils().roundedPhotoShimmer(radius: 30),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: sendButtonPressed,
                    child: Consumer<CommentNotifier>(builder: (context, commentNotifier, _) {
                      return commentNotifier.isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? CustomColors.lightModeDescriptionColor.withOpacity(0.4)
                                    : CustomColors.darkModeDescriptionColor.withOpacity(0.4),
                              ),
                            )
                          : Icon(
                              Icons.send,
                              size: 22,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? CustomColors.lightModeDescriptionColor.withOpacity(0.8)
                                  : CustomColors.darkModeDescriptionColor.withOpacity(0.8),
                            );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
