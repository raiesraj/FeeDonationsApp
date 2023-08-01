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
import '../Screens/profile_screen.dart';

///Hide and show bottom navigationBar

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

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
    return WillPopScope(
      onWillPop: () {
       int _currentIndex = DefaultTabController.of(context).index;
        if(_currentIndex == 0){
          
          return Future.value(true);
        }else{
          DefaultTabController.of(context).animateTo(0);
          return Future.value(false);
        }

      },
      child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar:
              Consumer<HomeScreenProvider>(builder: (context, bottomNavi, _) {
            return bottomNavi.showBottomNavigationBar
                ? _buildBottomNavigationBar()
                : const Offstage(offstage: true, child: Text(""));
          })),
    );
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

