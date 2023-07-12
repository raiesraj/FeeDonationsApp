import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static  snackBar(BuildContext context, String toastMessage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(toastMessage.toString())));
  }


static  Future<bool> isCollectionEmpty(String collectionPath) async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection(collectionPath).limit(1).get();

    return snapshot.size == 0;
  }

}
