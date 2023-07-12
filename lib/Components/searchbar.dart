import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utilis/app_colors.dart';
import 'custom_Text.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
  super.key,
  required,
  required this.onChanged,
  required this.onTap,
});

final ValueChanged<String> onChanged;
final VoidCallback onTap;
@override
State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.kSearchBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 56,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Something",
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.kHintTextColor,
                  ),
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.kButtonColor,
                    borderRadius: BorderRadius.circular(10)),
                height: 36,
                width: 90,
                child: Center(
                  child: CustomText(
                    text: "Search",
                    fontWeight: FontWeight.w700,
                    textSize: 16,
                    color: AppColor.kSearchBtnTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}