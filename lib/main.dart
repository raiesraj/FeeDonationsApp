import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Provider/signin_provider.dart';
import 'package:feedonations/Provider/signup_provider.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/nointernet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'Constant/bottom_navigation.dart';
import 'Provider/homescreen_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignUpAuthProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SignInProviderAuth()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fee Donations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  BottomNavigationExample()
      ),
    );
  }
}













class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  File? profilePic;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.ph,
            CupertinoButton(
                onPressed: () async {
                  XFile? selectedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (selectedImage != null) {
                    File convertedFile = File(selectedImage.path);
                    setState(() {
                      profilePic = convertedFile;
                    });
                  } else {
                    print("no image selected");
                  }
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      (profilePic != null) ? FileImage(profilePic!) : null,
                ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Pick"),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "Name",

              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(hintText: "Age"),
            ),
            20.ph,
            ElevatedButton(
              onPressed: () async {
                UploadTask uploadTask = FirebaseStorage.instance
                    .ref()
                    .child("profilePictures")
                    .child(const Uuid().v1())
                    .putFile(profilePic!);

                TaskSnapshot taskSnapshot = await uploadTask;
                String downloadUrl = await taskSnapshot.ref.getDownloadURL();

                Map<String, dynamic> newUserData = {
                  "name": nameController.text,
                  "email": emailController.text,
                  'age': ageController.text,
                  "profilePic": downloadUrl
                };
                _firestore.collection("Testing").doc().set(
                      newUserData,
                    );
              },
              child: const Text("Submit"),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Testing")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              return ListTile(
                                title: Text(userMap["name"]),
                                subtitle: Text(userMap["email"]),
                                leading: Text(userMap["age"]),
                                trailing: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    userMap["profilePic"].toString(),
                                  ),
                                ),
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(userMap["profilePic"]),

                              );
                            }),
                      );
                    } else {
                      return const Text("No data");
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
