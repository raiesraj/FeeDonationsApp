import 'dart:io';
import 'package:feedonations/Components/searchbar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Components/custom_Text.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/Donations.dart';
import 'package:feedonations/Screens/others_screen.dart';
import 'package:feedonations/Screens/school_screen.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:feedonations/Screens/university_screen.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../Components/eduBtn.dart';
import '../Components/recent_text.dart';
import '../Components/searchbar.dart';
import '../Utilis/app_colors.dart';
import 'college_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> allData = [];
  List<QueryDocumentSnapshot> searchResults = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }






///Recent Data From university Collection
  Future<void> fetchAllData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("RecentPost").orderBy("timestamp",descending: true).get();

    setState(() {
      allData = snapshot.docs;
    });
  }



  Future<List<QueryDocumentSnapshot>> alphabetSearch(String searchTerm) async {
    List<QueryDocumentSnapshot> results = [];

    searchTerm = searchTerm.toLowerCase();

    results = allData
        .where((docSnapshot) =>
            docSnapshot.get('name').toLowerCase().startsWith(searchTerm))
        .toList();

    return results;
  }

  void performAlphabetSearch(String searchTerm) async {
    List<QueryDocumentSnapshot> results = await alphabetSearch(searchTerm);

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  10.ph,
                  const TopAppBar(),
                  const Spacer(),
                  Image.asset(
                    AppImages().walletIcon,
                    height: 24,
                    width: 24,
                  ),
                  10.pw,
                  const CustomText(
                      text: "\$365.04",
                      fontWeight: FontWeight.w600,
                      textSize: 22)
                ],
              ),
            ),
            10.ph,
            CustomSearchBar(
              onTap: () {
                setState(() {
                  if (searchTerm.isNotEmpty) {
                    performAlphabetSearch(searchTerm);
                  } else {
                    AppSnackBar.snackBar(context, "Type something to Search");
                  }
                });
              },
              onChanged: (val) {
                setState(() {
                  searchTerm = val;
                });
                if (searchTerm.isNotEmpty) {
                  performAlphabetSearch(searchTerm);
                } else {
                  setState(() {
                    searchResults = [];
                  });
                }
              },
            ),
            30.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Hero(
                  tag: "school",
                  child: EduButton(
                    image: AppImages().schoolBag,
                    text: "School",
                    onTap: () {
                      RoutingPage().gotoNextPage(
                          context: context, gotoNextPage: const SchoolScreen());
                    },
                  ),
                ),
                EduButton(
                  image: AppImages().schoolImg,
                  text: "College",
                  onTap: () {
                    RoutingPage().gotoNextPage(
                        context: context, gotoNextPage: const CollegeScreen());
                  },
                ),
                EduButton(
                  image: AppImages().uniImg,
                  text: "University",
                  onTap: () {
                    RoutingPage().gotoNextPage(
                        context: context,
                        gotoNextPage: const UniversityScreen());
                  },
                ),
                EduButton(
                  image: AppImages().othersImg,
                  text: "Others",
                  onTap: () {
                    RoutingPage().gotoNextPage(
                        context: context, gotoNextPage: const OthersScreen());
                  },
                ),
              ],
            ),
            25.ph,
            const RecentText(),

            /// Getting Recent Post From University Collections
            /// to perform search on it
            20.ph,
            RecentRequestSearchFireBaseData(
                searchTerm: searchTerm,
                allData: allData,
                searchResults: searchResults),
          ],
        ),
      ),
    );
  }
}

class RecentRequestSearchFireBaseData extends StatelessWidget {
  const RecentRequestSearchFireBaseData({
    super.key,
    required this.searchTerm,
    required this.allData,
    required this.searchResults,
  });

  final String searchTerm;
  final List<QueryDocumentSnapshot<Object?>> allData;
  final List<QueryDocumentSnapshot<Object?>> searchResults;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: searchTerm.isEmpty
          ? allData.isEmpty
              ? const Center(child: Text('Loading data...'))
              : ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    var docSnapshot = allData[index];
                    // Display the desired fields from the document
                    return BeautifulCard(
                      country: docSnapshot.get("country"),
                      schoolName: docSnapshot.get("school"),
                      imageUrl: docSnapshot.get("profilePic"),
                      userName: docSnapshot.get("name"),
                      fee: docSnapshot.get("fee"),
                    );
                  },
                )
          : searchResults.isEmpty
              ? const Center(child: Text('No results found.'))
              : ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    var docSnapshot = searchResults[index];
                    return BeautifulCard(
                      imageUrl: docSnapshot.get("profilePic"),
                      userName: docSnapshot.get("name"),
                      fee: docSnapshot.get("fee"),
                      schoolName: docSnapshot.get("school"),
                      country: docSnapshot.get("country"),
                    );
                  },
                ),
    );
  }
}

class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key});

  @override
  _TopAppBarState createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  final picker = ImagePicker();
  File? _imageFile;
  bool _uploading = false;

  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data()!;
            final profilePictureUrl = data['profilePicture'] as String?;
            return GestureDetector(
              onTap: () {
                _showOptionsDialog();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (profilePictureUrl != null
                        ? NetworkImage(profilePictureUrl)
                            as ImageProvider<Object>
                        : AssetImage(AppImages().avatarImg)),
                child: _uploading
                    ? LoadingAnimationWidget.fallingDot(
                        color: Colors.redAccent, size: 40)
                    : (profilePictureUrl == null && _imageFile == null
                        ? Container()
                        : null),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }
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
    final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_pictures/$userId/$fileName');

    final uploadTask = firebaseStorageRef.putFile(_imageFile!);

    uploadTask.snapshotEvents.listen((event) {});

    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      await _updateProfilePicture(userId, downloadURL);
      AppSnackBar.snackBar(context, "Image Update Successful");
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
      await usersCollectionRef
          .doc(userId)
          .update({'profilePicture': pictureURL});
    }
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select an option'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _selectImage();
              },
              child: Text('Change Image'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                Image.network(_imageFile.toString());
              },
              child: Text('View Image'),
            ),
          ],
        );
      },
    );
  }
}
