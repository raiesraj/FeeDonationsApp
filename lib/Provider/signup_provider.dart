

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpAuthProvider with ChangeNotifier {
  UserCredential? userCredential;
  String?displayName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  void signUpValidation({
    required BuildContext context,
    required TextEditingController? nameController,
    required TextEditingController? email,
    required TextEditingController? password,
     String? displayName,
  }) async {
    loading = true;
    notifyListeners();
    if (nameController!.text.trim().isEmpty ||
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
                email: email.text, password: password.text

        );

        final String uid = userCredential!.user?.uid ??'';
         CollectionReference _userCollection = _firestore.collection("users");
         await _userCollection.doc(uid).set({
           'uid': uid,
           "name" : nameController.text,
           "email": email.text,

         });

          try {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              await user.updateDisplayName(displayName);

              this.displayName = displayName;
              notifyListeners();
            }
          } catch (e) {
            print('Error updating display name: $e');
          }




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
