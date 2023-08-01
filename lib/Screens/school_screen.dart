import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Components/app_bar.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Screens/testing.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({Key? key}) : super(key: key);

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    checkCollectionEmpty();
  }

  static Future<bool> isCollectionEmpty(String collectionPath) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("School").limit(1).get();

    return snapshot.size == 0;
  }

  Future<void> checkCollectionEmpty() async {
    bool empty = await isCollectionEmpty("School");
    setState(() {
      isEmpty = empty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "School",
      ),
      body:  SclUniOthersBg(
        child:  Hero(
          tag: "school",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ph,
              SclUniTopArea(
                text: "School Request",
              ),
              20.ph,
              Expanded(
                child: Center(
                  child: isEmpty
                      ? Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_0zomy8eb.json',
                    width: 500,
                    height: 300,
                    fit: BoxFit.contain,
                  )
                      : const DataFromFirebase(data: "School"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SclUniTopArea extends StatelessWidget {

  final String text;
  const SclUniTopArea({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: DefaultTextStyle(
              style: GoogleFonts.aBeeZee(fontSize: 22,color: Colors.teal),
              child: AnimatedTextKit(
                totalRepeatCount: 20,
                animatedTexts: [
                  FadeAnimatedText(text),
                  FadeAnimatedText(text),

                ],
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.school,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class SclUniOthersBg extends StatelessWidget {
  final Widget child;

  const SclUniOthersBg({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: AppColor.appBarcolor,
        ),
        Container(
          margin: const EdgeInsets.only(top: 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          child: child,
        ),
      ],
    );
  }
}
