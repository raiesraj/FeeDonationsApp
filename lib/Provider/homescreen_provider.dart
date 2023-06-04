import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Components/dropdown.dart';
import '../Screens/Donations.dart';






class HomeScreenProvider with ChangeNotifier{

  List<String> items = ['University', 'College', 'School', 'Others'];

  String? selectedValue;





  Widget myDropDown(){
    return  DropdownButtonHideUnderline(
      child: CustomDropdownButton2(
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 25,
          ),
          hint: 'Select',
          dropdownItems: items,
          value: selectedValue,
          onChanged: (value) {
              selectedValue = value;
           notifyListeners();
          }));

  }

  File? _profilePic;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  File? get profilePic => _profilePic;
  Future<void> selectImage(context) async{
    final picker = ImagePicker();
    final pickedImage  = await picker.pickImage(source: ImageSource.gallery);
     if(pickedImage != null){
       _profilePic = File(pickedImage.path);
       notifyListeners();

     }else{
       AppSnackBar.snackBar(context, "No Image Selected");
     }
  }
  void  sendData({required TextEditingController nameController})async{
    Timestamp timestamp = Timestamp.now();

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
        // "email": emailController.text,
        // 'age': ageController.text,
        "profilePic": downloadUrl
      };
      _firestore.collection(selectedValue.toString()).doc().set(
        newUserData,

      );
      notifyListeners();
    }


  }






