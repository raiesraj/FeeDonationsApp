import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Components/dropdown.dart';
import '../Routes/routes.dart';
import '../Screens/Donations.dart';
import '../Screens/university_screen.dart';






class HomeScreenProvider with ChangeNotifier {










  List<String> items = [
    "University",
    "College",
    "School",
    "Others",
  ];

  String? selectedValue;

  File? _profilePic;

  Widget myDropDown() {
    return CustomDropdownButton2(
        offset: Offset(220, 20),
        buttonHeight: 50,
        buttonDecoration: BoxDecoration(
          border: const Border.fromBorderSide(
            BorderSide(color: Colors.black),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 25,
        ),
        hint: 'Select the institute',
        dropdownItems: items,
        value: selectedValue,
        onChanged: (value) {
          selectedValue = value;
          notifyListeners();
        });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? get profilePic => _profilePic;

  Future<void> selectImage(context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _profilePic = File(pickedImage.path);
      notifyListeners();
    } else {
      AppSnackBar.snackBar(context, "No Image Selected");
    }
  }

  void sendProfile() async{
    if(profilePic != null){
      UploadTask uploadTask = FirebaseStorage.instance.ref().
    child("ProfilePictures").child(const Uuid().v1()).putFile(profilePic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      final fireStore = FirebaseFirestore.instance;
      final collection = fireStore.collection("ProfilePictures");
      final doc = await collection.add({
        "profilePic": downloadUrl,
      });
     final profilePictureId = doc.id;



    }else{
      print("something went to wrong");
    }



  }
  void sendData(
      {required TextEditingController nameController,
      context,
      required TextEditingController feeController}) async {
    Timestamp timestamp = Timestamp.now();

    if (selectedValue != null &&
        nameController.text.isNotEmpty &&
        profilePic != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(selectedValue.toString())
          .child(const Uuid().v1())
          .putFile(profilePic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> newUserData = {
        "name": nameController.text,
        "timestamp": timestamp,
        "value": selectedValue,
        "profilePic": downloadUrl,
        "fee": feeController.text
      };

      _firestore.collection(selectedValue.toString()).add(
            newUserData,
          );
    } else {
      AppSnackBar.snackBar(context, "Fill all the flied to Submit Form");
    }
  }
}
