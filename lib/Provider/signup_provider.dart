import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpAuthProvider with ChangeNotifier {
  UserCredential? userCredential;
  bool loading = false;
  void signUpValidation({
    required BuildContext context,
    required TextEditingController? name,
    required TextEditingController? email,
    required TextEditingController? password,
  }) async {
    loading = true;
    notifyListeners();
    if (name!.text.trim().isEmpty ||
        email!.text.isEmpty ||
        password!.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
          content: Text("Fill all the Filed"),

        ),

      );
      loading = false;
      notifyListeners();
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);

        final String uid = userCredential!.user?.uid ??'';
         CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
         await _userCollection .doc(uid).set({
           'uid': uid,
         });

        loading = false;
        notifyListeners();
      } on FirebaseException catch (e) {
        if (e.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(e.message.toString()),
            ),
          );
          loading = false;
          notifyListeners();
        }
        }
      }
    }
}
