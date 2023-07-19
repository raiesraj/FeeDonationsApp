import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/Donations.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../Components/custom_texflied.dart';
import '../Provider/profilescreenprovider.dart';
import '../Screens/post_request.dart';

///Hide and show bottom navigationBar

class BottomNavigationExample extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePageScreen(),
    const PostRequestScreen(),
    const RecentPost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar:
            Consumer<HomeScreenProvider>(builder: (context, bottomNavi, _) {
          return bottomNavi.showBottomNavigationBar
              ? _buildBottomNavigationBar()
              : const Offstage(offstage: true, child: Text(""));
        }));
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_add_outlined),
          label: "Form",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: "Profile",
        ),
      ],
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController profileName = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime? selectedDate;
  final dateFormat = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  ProfileScreenProvider? _profileScreenProvider;
  TextInputType _keyboardType = TextInputType.name;
  bool showCursor = false;
  String _currentName = '';
  @override
  void initState() {
    _profileScreenProvider =
        Provider.of<ProfileScreenProvider>(context, listen: false);
    _profileScreenProvider!.getName(profileName: profileName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileScreenProvider profileScreenProvider =
        Provider.of<ProfileScreenProvider>(context);
    var dateText = selectedDate != null ? dateFormat.format(selectedDate!) : '';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.actor(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(child: TopAppBar()),
            const ProfileText(text: "Name"),
            GestureDetector(
              onLongPress: () {
                setState(() {
                  showCursor = true;
                  _keyboardType = TextInputType.name;
                  profileScreenProvider.updateName(
                      profileName: profileName, context: context);
                });
              },
              child: CustomTextFiled(
                onTap: () {
                  setState(() {
                    _keyboardType = TextInputType.number;
                  });
                },
                onChanged: (value) {
                  _currentName = value;
                },
                controller: profileName,
                hintText: "",
                showCursor: showCursor,
                keyboardType: _keyboardType,
              ),
            ),
            const ProfileText(text: "Email"),
            CustomTextFiled(
              controller: profileName,
              hintText: user!.email.toString(),
              keyboardType: TextInputType.name,
            ),
            const ProfileText(text: "Password"),
            CustomTextFiled(
              controller: profileName,
              hintText: "**********",
              keyboardType: TextInputType.name,
            ),
            const ProfileText(text: "Date of Birth"),
            CustomTextFiled(
              onTap: () {
                _selectDate(context);
              },
              controller: TextEditingController(
                text: dateText,
              ),
              showCursor: false,
              hintText: selectedDate.toString(),
              keyboardType: TextInputType.none,
            ),
            const ProfileText(text: "Country"),
            CustomTextFiled(
              controller: profileName,
              hintText: "Nigeria",
              keyboardType: TextInputType.name,
            ),
            10.ph,
            MyButton(
                onTaP: () {
                  profileScreenProvider.getDateFromFirestore(dateController);
                  profileScreenProvider.updateName(
                      profileName: profileName, context: context);
                  profileScreenProvider.sendDateToFirebase(selectedDate!);
                },
                title: "Save Changes"),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

              

              stream: profileScreenProvider.getDate(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error loading date from Firestore');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                /// Extract the date value from the snapshot
                Timestamp timestamp = snapshot.data!['date'];
                DateTime date = timestamp.toDate();

                /// Format the date as desired
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);

                /// Display the formatted date on the screen
                return Text('Date: $formattedDate');
              },
            ),
          ],
        ),
      ),
    );
  }
}
