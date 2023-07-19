import 'dart:async';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/bottom_navigation.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Components/dropdown.dart';
import '../Routes/routes.dart';

class HomeScreenProvider with ChangeNotifier {
  bool isLoading = false;
  String? selectedPayment = "";



  List<String> items = [
    "University",
    "College",
    "School",
    "Others",
  ];

  String? selectedValue;



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
  File? _profilePic;
  File? get profilePic => _profilePic;

  Future<void> removeImage(context) async {
    if (_profilePic != null) {
      await _profilePic!.delete();
      _profilePic = null;
      AppSnackBar.snackBar(context, "Image removed");
      notifyListeners();
    }
  }

  Future<void> selectImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      _profilePic = File(pickedImage.path);
      notifyListeners();
    } else {
      AppSnackBar.snackBar(context, "No Image Selected");
    }
  }

  void sendData(
      {required TextEditingController nameController,
      required TextEditingController countryNameController,
      context,
      required TextEditingController feeController,
      required TextEditingController schoolNameController}) async {
    Timestamp timestamp = Timestamp.now();
    isLoading = true;
    showBottomNavigationBar = false;
    notifyListeners();
    if (selectedValue != null &&
        nameController.text.isNotEmpty &&
        feeController.text.isNotEmpty &&
        schoolNameController.text.isNotEmpty &&
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
        "fee": feeController.text,
        "school": schoolNameController.text,
        "country": countryNameController.text
      };
      _firestore.collection(selectedValue.toString()).add(
            newUserData,
          );
      final recentPost = _firestore.collection("RecentPost");
      if (sendDataToAnotherCollections == true) {
        recentPost.add(newUserData);
      }

      isLoading = true;
      _profilePic = null;
      selectedValue = null;
      feeController.clear();
      nameController.clear();
      countryNameController.clear();
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

  bool sendDataToAnotherCollections = false;

  bool _showBottomNavigationBar = true;

  bool get showBottomNavigationBar => _showBottomNavigationBar;

  set showBottomNavigationBar(bool value) {
    _showBottomNavigationBar = value;
    notifyListeners();
  }





  void showPaymentDialog(BuildContext context,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
                  return  AlertDialog(
                    title: Text('Select Payment Method'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("asds"),
                          onTap: () {
                            setSelectedOption(context, "asds");
                            Navigator.pop(context);

                          },
                        ),
                        ListTile(
                          title: Text('Payment Option 2'),
                          onTap: () {
                            setSelectedOption(context, "payment");
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
      },
    );
  }


  String _selectedOption = '';
  String get selectedOption => _selectedOption;

   setSelectedOption(context, String option) {
    _selectedOption = option;
    notifyListeners();

  }




}



