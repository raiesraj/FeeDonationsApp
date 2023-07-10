import 'dart:io';

import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePictureUploader extends StatefulWidget {
  @override
  _ProfilePictureUploaderState createState() => _ProfilePictureUploaderState();
}

class _ProfilePictureUploaderState extends State<ProfilePictureUploader> {
  final picker = ImagePicker();
  File? _imageFile;
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final profilePictureUrl = data['profilePicture'] as String?;

            return GestureDetector(
              onTap: _selectImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (profilePictureUrl != null
                    ? NetworkImage(profilePictureUrl)
                    :   AssetImage(AppImages().othersImg) as ImageProvider
                ),child: _uploading
                    ? CircularProgressIndicator()
                    : (profilePictureUrl == null && _imageFile == null
                    ? Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey[600],
                )
                    : null),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<void> _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _uploading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final firebaseStorageRef =
    firebase_storage.FirebaseStorage.instance.ref().child('profile_pictures/$userId/$fileName');

    final uploadTask = firebaseStorageRef.putFile(_imageFile!);

    uploadTask.snapshotEvents.listen((event) {
      // You can update a progress indicator or handle completion here
      // For example, show a circular progress indicator while uploading
    });

    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      await _updateProfilePicture(userId, downloadURL);
    } else {
      // Handle upload failure
    }

    setState(() {
      _uploading = false;
    });
  }

  Future<void> _updateProfilePicture(String? userId, String pictureURL) async {
    if (userId != null) {
      final usersCollectionRef = FirebaseFirestore.instance.collection('users');
      await usersCollectionRef.doc(userId).update({'profilePicture': pictureURL});
    }
  }
}

