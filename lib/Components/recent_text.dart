import 'package:feedonations/Constant/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_Text.dart';

class RecentText extends StatefulWidget {
  const RecentText({
    super.key,
  });

  @override
  State<RecentText> createState() => _RecentTextState();
}

class _RecentTextState extends State<RecentText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        25.pw,
        const CustomText(
          text: "Recent Request",
          fontWeight: FontWeight.w200,
          textSize: 16,
          color: Colors.black,
        ),
      ],
    );
  }
}