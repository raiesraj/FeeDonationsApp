import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreenProvider with ChangeNotifier{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController profileName = TextEditingController();


  String _currentName = "";

   getName({required TextEditingController profileName ,context,}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid) // Replace 'user_id' with the actual user ID
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {

          _currentName = docSnapshot.data()?['name'];
          notifyListeners();
          profileName.text = _currentName; // Set the current name in the TextField

      }
    });
  }

   updateName({required TextEditingController profileName ,context}) {
    String newName = profileName.text;
    if (newName.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid) // Replace 'user_id' with the actual user ID
          .update({'name': newName})
          .then((_) {
            _currentName = newName;
            notifyListeners();
        AppSnackBar.snackBar(context, "Name Updated");
      })
          .catchError((error) {
        // Error occurred
        print('Something wrong: $error');
      });
    }
  }


   getDateFromFirestore(TextEditingController dateController) async {
     User? user = _auth.currentUser;

    try {
      // Replace 'yourCollection' and 'yourDocumentId' with the appropriate collection and document IDs
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();

      if (snapshot.exists) {
        Timestamp timestamp = snapshot.get('date');
        DateTime date = timestamp.toDate();
        // Get the date field value from the snapshot
        dateController.text = date.toString();
        notifyListeners();

      }
    } catch (e) {
      print('Error retrieving date from Firestore: $e');
    }
  }







  void sendDateToFirebase( DateTime  date) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      // Check if user is authenticated
      if (user != null) {
        // Build the document reference using the user's UID
        DocumentReference dateRef = _firestore.collection('users').doc(user.uid);

        // Create the date document with the provided date
        await dateRef.update({
          'date': date,
        });
        notifyListeners();

        print('Date sent to Firebase successfully');
      }
    } catch (e) {
      print('Error sending date to Firebase: $e');
    }
  }
   getDate() {
    // Replace 'yourCollection' and 'yourDocumentId' with the appropriate collection and document IDs
    DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(
      _auth.currentUser!.uid,
    );

    return documentReference.snapshots();
  }


}

