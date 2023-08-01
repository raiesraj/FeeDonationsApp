import 'package:feedonations/Components/app_bar.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/school_screen.dart';
import 'package:feedonations/Screens/testing.dart';
import 'package:flutter/material.dart';

class CollegeScreen extends StatelessWidget {
  const CollegeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "College",
      ),
      body:  SclUniOthersBg(child: Column(
        children: [
          30.ph,
          const SclUniTopArea(text: "College Request"),
          20.ph,
          const Expanded(child: DataFromFirebase(data: "College"))
        ],
      ),),
    );
  }
}

//
