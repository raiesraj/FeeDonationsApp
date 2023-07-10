import 'package:feedonations/Screens/testing.dart';
import 'package:flutter/material.dart';

class CollegeScreen extends StatelessWidget {
  const CollegeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: const [
          Expanded(child: DataFromFirebase(data: "College"))
        ],
      ),


    );
  }
}