import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.name, required this.size, required this.fontWeight, required this.textColor});
  final String name;
  final double size;
  final FontWeight fontWeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: GoogleFonts.irishGrover(
        textStyle: TextStyle(
          color: textColor,
          fontSize: size,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
