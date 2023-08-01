import 'package:feedonations/Utilis/app_colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  MyAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appBarcolor,
      elevation: 0,
      centerTitle: true,
      title: Text(title!),
      leading: const BackButton(
        //color: Colors.grey,
      ),
      // Customize your AppBar as needed
      // Add actions, icons, or any other components you want to include
    );
  }
}