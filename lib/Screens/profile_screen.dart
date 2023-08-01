import 'package:feedonations/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/homescreen_provider.dart';
import '../Routes/routes.dart';
import '../Utilis/app_colors.dart';
import 'Donations.dart';
import 'edit_profile_screen.dart';


class RecentPost extends StatefulWidget {
  const RecentPost({Key? key}) : super(key: key);

  @override
  State<RecentPost> createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.actor(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileText(
              text: "Account",
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                height: 180,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColor.profileContainerBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    ProfileDetails(
                      iconData: Icons.person,
                      text: 'Edit Profile',
                      onTap: () {
                        RoutingPage().gotoNextPage(
                            context: context,
                            gotoNextPage: const EditProfileScreen());
                      },
                    ),
                    ProfileDetails(
                      iconData: Icons.security,
                      text: "Security",
                      onTap: () {},
                    ),
                    ProfileDetails(
                      iconData: Icons.notifications,
                      text: "Notifications",
                      onTap: () {},
                    ),
                    ProfileDetails(
                      iconData: Icons.lock,
                      text: "Privacy",
                      onTap: () {},
                    ),
                  ],
                )),
            const ProfileText(
              text: 'Support And About',
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                height: 160,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColor.profileContainerBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    ProfileDetails(
                      iconData: Icons.workspace_premium,
                      text: 'My Subscriptions',
                      onTap: () {},
                    ),
                    ProfileDetails(
                      iconData: Icons.contact_support_outlined,
                      text: "Help and Support",
                      onTap: () {},
                    ),
                    ProfileDetails(
                      iconData: Icons.policy,
                      text: "Terms and Policy",
                      onTap: () {},
                    ),
                    Consumer<HomeScreenProvider>(
                        builder: (context, notifier, _) {
                          return Row(
                            children: [
                              Expanded(
                                child: SwitchListTile(
                                  title: const Text("Recent Req"),
                                  value: notifier.sendDataToAnotherCollections,
                                  onChanged: (value) {
                                    setState(() {
                                      notifier.sendDataToAnotherCollections = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                )),
            const ProfileText(
              text: "Actions",
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                height: 85,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColor.profileContainerBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    ProfileDetails(
                      iconData: Icons.manage_accounts,
                      text: "Add account",
                      onTap: () {
                        RoutingPage().gotoNextPage(
                          context: context,
                          gotoNextPage: const SignUpScreen(),
                        );
                      },
                    ),
                    ProfileDetails(
                      iconData: Icons.login_outlined,
                      text: "LogOut",
                      onTap: () async {
                        _showLogoutConfirmationDialog(context);
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: GoogleFonts.actor(fontSize: 17, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                RoutingPage().gotoNextPage(
                    context: context, gotoNextPage: const SignUpScreen());
              },
              child: Text(
                'Yes',
                style: GoogleFonts.actor(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}