import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:feedonations/Screens/signin_screen.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';





class BeautifulCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String fee;

  BeautifulCard({required this.imageUrl, required this.userName, required this.fee});

  void _showImagePreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: Colors.black,
          child: Image.network(imageUrl),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: InkWell(
                onTap: (){
                  _showImagePreview(context);
                },
                child: Image.network(
                  imageUrl,
                  height: 180,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text('Rs  $fee',style: GoogleFonts.aBeeZee(fontSize: 14,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Donate for kids to their well being',
                        style: TextStyle(fontSize: 16),
                      ),
                       Spacer(),
                      Container(
                        height: 23,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColor.kducationBtnBgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            onTap: (){},
                              child: const Center(child: Text("Donate")))),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class RecentPost extends StatefulWidget {
  const RecentPost({Key? key}) : super(key: key);

  @override
  State<RecentPost> createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:TextButton(
        onPressed: ()async{
          FirebaseAuth.instance.signOut();
          RoutingPage().gotoNextPage(context: context, gotoNextPage: const SignUpScreen());
        },
        child: Text(
          "LogOut",
        ),
      )
    );
  }




  }

