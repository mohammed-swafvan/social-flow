import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_flow/presentation/utils/colors.dart';
import 'package:social_flow/providers/login_screen_provider.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEdingController;
  final bool isPass;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  const TextFieldWidget({
    super.key,
    required this.textEdingController,
    this.isPass = false,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: kMainColor,
        width: 2,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
    );
    final textStyle = TextStyle(color: kGreyColor);
    final value = Provider.of<LoginScreenProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: textEdingController,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textStyle,
            labelText: labelText,
            labelStyle: textStyle,
            floatingLabelStyle: TextStyle(color: kMainColor),
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 8,
            ),
            suffixIcon: isPass
                ? IconButton(
                    onPressed: () {
                      value.visibilityChanging();
                    },
                    icon: Icon(
                      value.visibility ? Icons.visibility_off_outlined : Icons.visibility,
                      color: kWhiteColor.withOpacity(0.5),
                    ),
                  )
                : const SizedBox()),
        style: TextStyle(color: kWhiteColor),
        keyboardType: textInputType,
        obscureText: isPass ? value.visibility : false,
      ),
    );
  }
}
