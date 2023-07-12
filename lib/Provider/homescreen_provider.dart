import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/bottom_navigation.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Components/dropdown.dart';
import '../Routes/routes.dart';
import '../Screens/Donations.dart';
import '../Screens/university_screen.dart';
import '../main.dart';

class HomeScreenProvider with ChangeNotifier {
  bool isLoading = false;

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
        offset: const Offset(220, 20),
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








  void sendData(
      {required TextEditingController nameController,
      context,
      required TextEditingController feeController}) async {
    Timestamp timestamp = Timestamp.now();
    isLoading = true;
    showBottomNavigationBar = false;
    notifyListeners();
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

      isLoading = true;
      _profilePic = null;
      selectedValue = null;
      feeController.clear();
      nameController.clear();
      showBottomNavigationBar = true;
      notifyListeners();
      AppSnackBar.snackBar(context, "Post Successful Done");
      isLoading = false;
      showBottomNavigationBar = true;
      notifyListeners();
      RoutingPage().gotoNextPage(
          context: context, gotoNextPage: BottomNavigationExample());
    } else {
      AppSnackBar.snackBar(context, "Check All the Details ");
      isLoading = false;
      showBottomNavigationBar = true;
      notifyListeners();
    }
  }

  bool _showBottomNavigationBar = true;

  bool get showBottomNavigationBar => _showBottomNavigationBar;

  set showBottomNavigationBar(bool value) {
    _showBottomNavigationBar = value;
    notifyListeners();
  }
}
