import 'package:feedonations/Constant/sized_box.dart';
import 'package:flutter/material.dart';

import 'custom_Text.dart';

class RecentText extends StatelessWidget {
  const RecentText({
    super.key,
  });

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