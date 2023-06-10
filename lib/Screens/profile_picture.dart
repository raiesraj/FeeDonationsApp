// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// class ProfilePictureUploadScreen extends StatefulWidget {
//   @override
//   _ProfilePictureUploadScreenState createState() =>
//       _ProfilePictureUploadScreenState();
// }
//
// class _ProfilePictureUploadScreenState
//     extends State<ProfilePictureUploadScreen> {
//   String? _imagePath;
//
//   Future<String> uploadProfilePicture(String userId, String imagePath) async {
//     final ref = firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('profile_pictures')
//         .child('$userId.jpg');
//     final uploadTask = ref.putFile(File(imagePath));
//
//     final snapshot = await uploadTask.whenComplete(() {});
//     if (snapshot.state == firebase_storage.TaskState.success) {
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } else {
//       throw Exception('Failed to upload profile picture.');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Profile Picture'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_imagePath != null) Image.file(File(_imagePath!)),
//               ElevatedButton(
//                 onPressed: _selectAndUploadImage,
//                 child: Text('Select Image'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
