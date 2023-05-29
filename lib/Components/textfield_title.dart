import 'package:flutter/material.dart';

import 'custom_Text.dart';
class TextFiledTitle extends StatelessWidget {
  final String title;
  const TextFiledTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 27),
      child: CustomText(text: title, fontWeight: FontWeight.w700, textSize: 14,color: Colors.black),
    );
  }
}