import 'package:feedonations/Constant/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider with ChangeNotifier {
  bool isLoading = false;

  bool isEmailSend =false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController forgetPasswordController = TextEditingController();

  forgetPassword(
      {required TextEditingController forgetPasswordController,
      required context}) async {
    try {
      isLoading = true;
      forgetPasswordController.clear();
      notifyListeners();
      await _auth.sendPasswordResetEmail(email: forgetPasswordController.text);
      forgetPasswordController.clear();
      isEmailSend = true;
      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      if (e.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message.toString()),
        ));
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
