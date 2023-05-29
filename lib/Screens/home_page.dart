import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final fireStore = FirebaseFirestore.instance.collection("images").snapshots();

  XFile? _image;
  String? _uploadedImageUrl;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print("select Image");
    }

    int date = DateTime.now().microsecondsSinceEpoch;
    final Reference storageReference =

        FirebaseStorage.instance.ref("images$date");
    final TaskSnapshot taskSnapshot =
        await storageReference.putFile(File(_image!.path));
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _uploadedImageUrl = downloadUrl;
    });
  }
//
//  imageBox (){
//     return _firestore.collection("images").
//   get().then((value) => (QuerySnapshot querySnapshot){
//     querySnapshot.docs.forEach((doc) {
//       setState(() {
//        _bannerImage.add(doc["images"]);
//       });
//     });
//     });
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                  builder: (BuildContext context,AsyncSnapshot <QuerySnapshot>snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Text("Waiting");
                  }
                  if(snapshot.hasError){
                    const Text("Something Wrong");
                  }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                      //String url = snapshot.data!.docs[index]["email"];
                    return Text(snapshot.data!.docs[index]["downloadUrl"]);
                  }),
                );
              }),




          if (_image != null)
            Image.file(
              File(
                _image!.path,
              ),
              height: 200,
            ),
          TextButton(
            onPressed: () {
              _pickImage();
            },
            child: const Text("Pick"),
          ),



        ],
      ),
    );
  }
}
