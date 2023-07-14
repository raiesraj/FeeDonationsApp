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
    return  Scaffold(
      appBar: AppBar(
        title: const Text("University"),
      ),
      body: const Column(
        children: [

          Expanded(child: DataFromFirebase(data: "University"))
        ],
      ),
    );
  }
}
