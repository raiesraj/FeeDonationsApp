import 'package:cloud_firestore/cloud_firestore.dart';
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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    );
  }
}


