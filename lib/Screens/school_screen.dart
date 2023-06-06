import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Screens/testing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({Key? key}) : super(key: key);

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    checkCollectionEmpty();
  }

  static Future<bool> isCollectionEmpty(String collectionPath) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("School").limit(1).get();

    return snapshot.size == 0;
  }

  Future<void> checkCollectionEmpty() async {
    bool empty = await isCollectionEmpty("School");
    setState(() {
      isEmpty = empty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.grey,
        ),
      ),
      backgroundColor: Colors.white,
      body: Hero(
        tag: "school",
        child: Column(
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
                    : const DataFromFirebase(data: "School"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
