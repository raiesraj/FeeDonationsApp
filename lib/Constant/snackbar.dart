import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void snackBar(BuildContext context, String toastMessage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(toastMessage.toString())));
  }

}
