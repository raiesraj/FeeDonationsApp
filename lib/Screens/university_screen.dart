import 'package:feedonations/Components/app_bar.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/school_screen.dart';
import 'package:feedonations/Screens/testing.dart';
import 'package:flutter/material.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key? key}) : super(key: key);

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "University",
        ),
        body: SclUniOthersBg(
          child: Column(
            children: [
              30.ph,
              const SclUniTopArea(text: "UniverSity Request"),
              20.ph,
              const Expanded(child: DataFromFirebase(data: "University"))
            ],
          ),
        ));
  }
}
