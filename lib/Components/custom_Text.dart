import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double textSize;



  const CustomText({
    super.key, required this.text,   this.color, required this.fontWeight, required this.textSize,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: textSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}