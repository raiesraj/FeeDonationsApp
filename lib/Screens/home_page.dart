import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Components/custom_Text.dart';
import 'package:feedonations/Components/custom_texflied.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/Donations.dart';
import 'package:feedonations/Screens/university_screen.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../Utilis/app_colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopAppBar(),
            10.ph,
             SearchBar(

             ),
            30.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                EduButton(
                  text: "School",
                ),
                EduButton(
                  text: "College",
                ),
                EduButton(
                  text: "University",
                ),
                EduButton(
                  text: "Others",
                ),
              ],
            ),
            25.ph,
            Row(
              children: [
                25.pw,
                const CustomText(
                  text: "Recent Request",
                  fontWeight: FontWeight.w200,
                  textSize: 16,
                  color: Colors.black,
                ),
              ],
            ),
            20.ph,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Testing")
                    .orderBy("timestamp", descending: true)
                    .limit(4)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ///Getting Data bY calling userMap
                            Map<String, dynamic> userMap =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return Column(
                              children: [
                                // Container(
                                //   height: 100,
                                //   width: 200,
                                //   color: Colors.red,
                                //    child: Column(
                                //      children: [
                                //        Image(
                                //          fit: BoxFit.fitWidth,
                                //          height: 80,
                                //          image: NetworkImage(
                                //    userMap["profilePic"].toString(),
                                //        ),
                                //        ),
                                //        Text(userMap["name"]),
                                //      ],
                                //    )
                                // ),

                                //

                                  BeautifulCard(imageUrl: userMap ['profilePic'], userName: userMap['name']),

                              ],
                            );
                          });
                    } else {
                      return const Text("No data");
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            //   Expanded(
            //     child: ListView.builder(
            //      padding: const EdgeInsets.only(bottom: 40),
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 4,
            //         itemBuilder: (context,int index){
            //       return  Card(
            //         margin: const EdgeInsets.symmetric(horizontal: 10,),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Column(
            //           children: [
            //             ClipRRect(
            //               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            //               child: Image.asset(
            //                 "assets/Images/donations.png",
            //                 // height: 180,
            //                 height: 140,
            // fit: BoxFit.fitWidth,
            //               ),
            //             ),
            //             Row(
            //              //crossAxisAlignment: CrossAxisAlignment.start,
            //                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 50.ph,
            //                 const Text(
            //                   "Donate for kids to their well being",
            //                   style: TextStyle(
            //                    fontSize: 18,
            //                    fontWeight: FontWeight.bold,
            //                  ),
            //                ),
            //                //const SizedBox(height: 8),
            //              ],
            //            ),
            //            Row(
            //              crossAxisAlignment: CrossAxisAlignment.start,
            //              children: [
            //                Text(
            //                  'FEE\ 200PKR',
            //                  style: GoogleFonts.poppins(
            //                    fontWeight: FontWeight.w600,
            //                    fontSize: 15,
            //                  ),
            //                ),
            //                10.pw,
            //                Text(
            //                  'KIU',
            //                  style: GoogleFonts.poppins(
            //                    fontWeight: FontWeight.w600,
            //                    fontSize: 15,
            //                  ),
            //                ),
            //              ],
            //            ),
            //            CupertinoButton(
            //              padding: EdgeInsets.zero,
            //              onPressed: () {},
            //              child: Container(
            //                decoration: BoxDecoration(
            //                    color: AppColor.kButtonColor,
            //                    borderRadius: BorderRadius.circular(10)),
            //                height: 36,
            //                width: 70,
            //                child: Center(
            //                  child: CustomText(
            //                    text: "Donate",
            //                    fontWeight: FontWeight.w600,
            //                    textSize: 14,
            //                    color: AppColor.kSearchBtnTextColor,
            //                  ),
            //                ),
            //              ),
            //            ),
            //  //           Lottie.network(
            //  //             'https://assets10.lottiefiles.com/packages/lf20_ocBLovFChM.json', // Replace with your Lottie animation file path
            //  //             width: 500,
            //  //             height: 300,
            //  //             fit: BoxFit.contain,
            //  //
            //  //           )
            //
            //
            // ],
            //         ),
            //       );
            //     }),
            //   )
          ],
        ),
      ),
    );
  }
}

class EduButton extends StatelessWidget {
  final String text;

  const EduButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            RoutingPage().gotoNextPage(context: context, gotoNextPage: UniversityScreen());
          },
          child: Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.kducationBtnBgColor,
            ),
            child: Center(
              child: Image.asset(
                AppImages().eduImg,
                height: 24,
              ),
            ),
          ),
        ),
        15.ph,
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColor.kHintTextColor,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {


   SearchBar({super.key,
     requireds

  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
 var search = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.kSearchBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 56,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                     search = val;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Something",
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.kHintTextColor,
                  ),
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.kButtonColor,
                    borderRadius: BorderRadius.circular(10)),
                height: 36,
                width: 90,
                child: Center(
                  child: CustomText(
                    text: "Search",
                    fontWeight: FontWeight.w700,
                    textSize: 16,
                    color: AppColor.kSearchBtnTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RoundedElevatedButton extends StatelessWidget {
//   final double borderRadius;
//   final VoidCallback onPressed;
//   final Widget child;
//
//   RoundedElevatedButton({
//     required this.borderRadius,
//     required this.onPressed,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           minimumSize: (Size.fromWidth(2)),
//         ),
//         onPressed: onPressed,
//         child: child,
//       ),
//     );
//   }
// }

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CupertinoButton(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(AppImages().profileImg),
            ),
            onPressed: () {},
          ),
          const Spacer(),
          Image.asset(
            AppImages().walletIcon,
            height: 24,
            width: 24,
          ),
          10.pw,
          const CustomText(
              text: "\$365.04", fontWeight: FontWeight.w600, textSize: 22)
        ],
      ),
    );
  }
}
