import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:feedonations/Screens/profle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInProviderAuth with ChangeNotifier {
  UserCredential? userCredential;
  bool loading = false;


  void signInValidation(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext context}) async {
    loading = true;
    notifyListeners();
    if (email.text.isEmpty || password.text.isEmpty) {
      AppSnackBar.snackBar(context, "Fill all the Details");
      loading = false;
      notifyListeners();
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        final User? user = FirebaseAuth.instance.currentUser;
        String uid = '';
        if(user != null){
          uid = user.uid;
          final userCollection = FirebaseFirestore.instance.collection('users');
          await userCollection.doc(uid).set({uid : uid,});
        }

        loading = false;
        notifyListeners();
        RoutingPage()
            .gotoNextPage(context: context, gotoNextPage: ProfilePage());
      } on FirebaseException catch (e) {
        if (e.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
          ));
          loading = false;
          notifyListeners();
        }
      }
    }
  }
}
