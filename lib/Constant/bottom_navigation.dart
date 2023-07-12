import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Screens/Donations.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      bottomNavigationBar:Consumer<HomeScreenProvider>(
        builder: (context, bottomNavi, _){
          return bottomNavi.showBottomNavigationBar? _buildBottomNavigationBar()
        : const SizedBox();}

      )

    );}
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      }, items: const [
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


