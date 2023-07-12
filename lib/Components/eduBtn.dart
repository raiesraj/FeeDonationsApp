import 'package:feedonations/Constant/sized_box.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utilis/app_colors.dart';

class EduButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String image;

  const EduButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Center(
              child: Image.asset(
                image,
                height: 50,
              ),
            ),
          ),
        ),
        15.ph,
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColor.kHintTextColor,
          ),
        ),
      ],
    );
  }
}