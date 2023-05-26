import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Utilis/appText.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_Text.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            40.ph,
            Center(child: Image.asset(AppImages().appLogo),),
            23.ph,
            CustomText(
              text: AppText().createText,
              fontWeight: FontWeight.w400,
              textSize: 28,
            ),
            6.ph,
          ],
        ),
      ),

    );
  }
}


