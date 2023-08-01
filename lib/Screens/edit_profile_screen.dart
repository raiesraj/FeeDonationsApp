
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Components/custom_texflied.dart';
import '../Provider/profilescreenprovider.dart';
import 'Donations.dart';
import 'home_page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController profileName = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
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
              controller: emailController,
              hintText: user!.email.toString(),
              keyboardType: TextInputType.name,
            ),
            const ProfileText(text: "Password"),
            CustomTextFiled(
              controller: passwordController,
              hintText: "**********",
              keyboardType: TextInputType.name,
            ),
            // const ProfileText(text: "Date of Birth"),
            // CustomTextFiled(
            //   onTap: () {
            //     _selectDate(context);
            //   },
            //   controller: TextEditingController(
            //     text: dateText,
            //   ),
            //   showCursor: false,
            //   hintText: selectedDate.toString(),
            //   keyboardType: TextInputType.none,
            // ),
            10.ph,
            MyButton(
                onTaP: () {
                  profileScreenProvider.getDateFromFirestore(dateController);
                  profileScreenProvider.updateName(
                      profileName: profileName, context: context);
                  profileScreenProvider.sendDateToFirebase(selectedDate!);
                },
                color: Colors.red,
                title: "Save Changes"),
            // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            //
            //
            //
            //   stream: profileScreenProvider.getDate(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error loading date from Firestore');
            //     }
            //
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     }
            //
            //     /// Extract the date value from the snapshot
            //     Timestamp timestamp = snapshot.data!['date'];
            //     DateTime date = timestamp.toDate();
            //
            //     /// Format the date as desired
            //     String formattedDate = DateFormat('yyyy-MM-dd').format(date);
            //
            //     /// Display the formatted date on the screen
            //     return Text('Date: $formattedDate');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}