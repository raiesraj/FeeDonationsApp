import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Components/app_bar.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/school_screen.dart';
import 'package:feedonations/Screens/testing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({Key? key}) : super(key: key);

  @override
  State<OthersScreen> createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    checkCollectionEmpty();
  }

  static Future<bool> isCollectionEmpty(String collectionPath) async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection("Others").limit(1).get();

    return snapshot.size == 0;
  }

  Future<void> checkCollectionEmpty() async {
    bool empty = await isCollectionEmpty("Others");
    setState(() {
      isEmpty = empty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar(
        title: "Others",
      ),
      body: SclUniOthersBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            50.ph,
            const SclUniTopArea(text: "Others Request"),
            10.ph,
            Expanded(
              child: Center(
                child: isEmpty
                    ? Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_0zomy8eb.json',
                  width: 500,
                  height: 300,
                  fit: BoxFit.contain,
                )
                    : const DataFromFirebase(data: "Others"),
              ),
            )
          ],
        ),
      )
    );
  }
}


