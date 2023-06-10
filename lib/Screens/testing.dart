import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Components/custom_texflied.dart';
import 'package:feedonations/Components/dropdown.dart';
import 'package:feedonations/Screens/Donations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Constant/snackbar.dart';
import '../Utilis/app_colors.dart';
import '../Utilis/images.dart';
//
// class SendDataWithCatogoreis extends StatefulWidget {
//   const SendDataWithCatogoreis({Key? key}) : super(key: key);
//
//   @override
//   State<SendDataWithCatogoreis> createState() => _SendDataWithCatogoreisState();
// }
//
// class _SendDataWithCatogoreisState extends State<SendDataWithCatogoreis> {
//
//   TextEditingController checkController = TextEditingController();
//   TextEditingController feeController = TextEditingController();
//
//
//
//
//
//
//
//   File? selectedImage;
//
//   void addToFirestore(String value,TextEditingController checkController) async {
//     try {
//
//       UploadTask uploadTask = FirebaseStorage.instance.ref().
//           child(selectedValue.toString()).child(const Uuid().v1()).putFile(selectedImage!);
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//
//       CollectionReference collection = FirebaseFirestore.instance.collection(selectedValue.toString());
//       await collection.add({
//         "name": checkController.text,
//         'value': selectedValue,
//         'timestamp': DateTime.now(),
//         "pic": downloadUrl
//       });
//       print('Selected value added to Firestore');
//     } catch (e) {
//       print('Error adding selected value to Firestore: $e');
//     }
//   }
//
//
//  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//
//
//   Future<void> selectImage(context) async{
//     final picker = ImagePicker();
//     final pickedImage  = await picker.pickImage(source: ImageSource.gallery);
//     if(pickedImage != null){
//       setState(() {
//         selectedImage = File(pickedImage.path);
//       });
//
//
//     }else{
//       AppSnackBar.snackBar(context, "No Image Selected");
//     }
//   }
//  void upadateF(value){
//     setState(() {
//       addToFirestore(value!,checkController,);
//     });
//  }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CupertinoButton(
//             onPressed: () {
//              selectImage(context);
//             },
//             child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: (selectedImage != null)
//                     ? FileImage(selectedImage!)
//                     : null
//             ),
//           ),
//           CustomTextFiled(controller: checkController, hintText: "Name"),
//           Center(
//             child:
//           ),
//           TextButton(
//             onPressed: (){
//             setState(() {
//
//             });
//           }, child: Text("done"),),
//           const Text("School",style: TextStyle(fontSize: 40),),
//
//           const DataFromFirebase(
//             data: "School",
//           ),
//           const Text("College",style: TextStyle(fontSize: 40),),
//           const DataFromFirebase(
//             data: "College",
//           ),
//           const Text("University",style: TextStyle(fontSize: 40),),
//           const DataFromFirebase(
//             data: "University",
//           ),
//           const Text("Others",style: TextStyle(fontSize: 40),),
//           const DataFromFirebase(data: "Others"),
//
//           // Expanded(
//           //   child: StreamBuilder<QuerySnapshot>(
//           //     stream: FirebaseFirestore.instance
//           //         .collection('College')
//           //         .orderBy("timestamp", descending: true)
//           //         .limit(4)
//           //         .snapshots(),
//           //     builder: (context, AsyncSnapshot snapshot) {
//           //       if (snapshot.connectionState == ConnectionState.active) {
//           //         if (snapshot.hasData && snapshot.data != null) {
//           //           return ListView.builder(
//           //               itemCount: snapshot.data!.docs.length,
//           //               itemBuilder: (context, index) {
//           //                 ///Getting Data bY calling userMap
//           //                 Map<String, dynamic> userMap =
//           //                 snapshot.data!.docs[index].data()
//           //                 as Map<String, dynamic>;
//           //                 return Column(
//           //                   children: [
//           //                     // Container(
//           //                     //   height: 100,
//           //                     //   width: 200,
//           //                     //   color: Colors.red,
//           //                     //    child: Column(
//           //                     //      children: [
//           //                     //        Image(
//           //                     //          fit: BoxFit.fitWidth,
//           //                     //          height: 80,
//           //                     //          image: NetworkImage(
//           //                     //    userMap["profilePic"].toString(),
//           //                     //        ),
//           //                     //        ),
//           //                     //        Text(userMap["name"]),
//           //                     //      ],
//           //                     //    )
//           //                     // ),
//           //                     Text(userMap["name"]),
//           //                     //
//           //                   ],
//           //                 );
//           //               });
//           //         } else {
//           //           return const Text("No data");
//           //         }
//           //       } else {
//           //         return const Center(child: CircularProgressIndicator());
//           //       }
//           //     },
//           //   ),
//           // ),
//         ],
//       ),
//
//     );
//   }
// }
//
class DataFromFirebase extends StatelessWidget {
  final String data;

  const DataFromFirebase({
    super.key, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(data)
          .orderBy("timestamp", descending: true)
          .limit(4)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ///Getting Data bY calling userMap
                  Map<String, dynamic> userMap =
                  snapshot.data!.docs[index].data()
                  as Map<String, dynamic>;
                  return Column(
                    children: [
                      // Container(
                      //   height: 100,
                      //   width: 200,
                      //   color: Colors.red,
                      //    child: Column(
                      //      children: [
                      //        Image(
                      //          fit: BoxFit.fitWidth,
                      //          height: 80,
                      //          image: NetworkImage(
                      //    userMap["profilePic"].toString(),
                      //        ),
                      //        ),
                      //        Text(userMap["name"]),
                      //      ],
                      //    )
                      // ),
                      BeautifulCard(imageUrl: userMap["profilePic"], userName: userMap["name"], fee: userMap['fee'],),


                    ],
                  );
                });
          } else {
            return const Text("No data");
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
