import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/bottom_navigation.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Constant/snackbar.dart';
import 'package:feedonations/Provider/homescreen_provider.dart';
import 'package:feedonations/Provider/paymentProvider.dart';
import 'package:feedonations/Routes/routes.dart';
import 'package:feedonations/Screens/googlePay.dart';
import 'package:feedonations/Screens/jazzcash_payment.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:feedonations/Screens/signin_screen.dart';
import 'package:feedonations/Utilis/app_colors.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'home_page.dart';

class BeautifulCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String fee;
  final String schoolName;
  final String country;

  BeautifulCard(
      {super.key,
      required this.imageUrl,
      required this.userName,
      required this.fee,
      required this.schoolName,
      required this.country});

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

  TextEditingController paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      _showImagePreview(context);
                    },
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 160,
                            ),
                          );
                        }
                      },
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
                          Row(
                            children: [
                              Text(
                                "Name :",
                                style: GoogleFonts.actor(),
                              ),
                              10.pw,
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              'Rs  $fee',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      15.ph,
                      Row(
                        children: [
                          const Text(
                            "Country: ",
                          ),
                          10.pw,
                          Text(
                            country,
                            style: GoogleFonts.lato(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.flag_outlined,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Academy :",
                            style: GoogleFonts.actor(),
                          ),
                          10.pw,
                          Text(
                            schoolName,
                            style: GoogleFonts.lato(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 43,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColor.kButtonColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Tooltip(
                              message: "Payment",
                              child: InkWell(
                                splashColor: Colors.red,
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: AppColor.paymentBgColor,
                                    // isDismissible: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  PaymentCard(paymentController: paymentController) ;
                                    },
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "Donate",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    super.key, required TextEditingController paymentController,

  });



  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {



  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context,listen: false);
    return Consumer<HomeScreenProvider>(builder: (context,provider,_){
      return  Container(
        padding: const EdgeInsets.only(top: 0),
        height: context.height * 8,
        decoration: BoxDecoration(
          color: AppColor.paymentSecondBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.ph,
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColor.paymentIconColor,
                      size: 20,
                    ),
                    10.pw,
                    Text(
                      "Back",
                      style: GoogleFonts.aBeeZee(
                          color: AppColor.paymentIconColor, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Payment",
                style: GoogleFonts.actor(
                    fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 34),
              height: context.height * 0.7,
              width: context.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 15),
                    child: TopAppBar(),
                  ),
                  15.ph,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    width: context.width,
                    decoration: BoxDecoration(
                      color: AppColor.paymentBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () {
                        provider.showPaymentDialog(context);
                      },
                      leading:  Icon(
                        Icons.atm_sharp,
                        size: 50,
                      ),
                      title:Text(provider.selectedOption.isNotEmpty ? provider.selectedOption : "Select Payment Method"),
                      subtitle: const Text("MasterCard"),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      "Rs",
                      style: GoogleFonts.aBeeZee(fontSize: 23),
                    ),
                  ),
                  TextFormField(
                    onChanged: (text){
                    paymentProvider.calculateFivePercent();

                    },
                    style: GoogleFonts.aBeeZee(fontSize: 100),
                    showCursor: false,
                    controller: paymentProvider.paymentController,
                    keyboardType: TextInputType.number,
                    textAlign:
                    TextAlign.center, // Text alignment set to center
                    decoration: const InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(fontSize: 100),
                      border: InputBorder.none, // No underline
                    ),
                  ),
                   Visibility(
                     visible: paymentProvider.paymentController.text.isEmpty ? isShow = false : true,
                       child: Center(
                         child: Text("Remaining Amount ${paymentProvider.remainingAmount.toString()}"),
                       ),
                   ),
                      Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 40,
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.payBankBgColor,
                      ),
                      child: Row(
                        children: [
                          30.pw,
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.kducationBtnBgColor,
                            ),
                            child: Center(
                              child: Text(
                              paymentProvider.calculatedValue.toString(),
                                style: GoogleFonts.actor(fontSize: 15),
                              ),
                            ),
                          ),
                          20.pw,
                          Text(
                            "Fee will be charged ",
                            style: GoogleFonts.roboto(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: MyButton(
                onTaP:  provider.selectedOption.isNotEmpty ? (){
                  performAction(context);
                  paymentProvider.paymentController.clear();

                } : AppSnackBar.snackBar(context, "Select payment Method"),
                title: "Payment",
                color: AppColor.paymentBtnBgColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}

performAction(context){

  final selectedOption = HomeScreenProvider().selectedOption;
  if(selectedOption == "asds"){
    AppSnackBar.snackBar(context, "asds");
  }else{
   if(selectedOption == "Payment Options 2"){
     AppSnackBar.snackBar(context, "two");
    }
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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
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

class ProfileText extends StatelessWidget {
  final String text;
  const ProfileText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
      ),
      child: ListTile(
        title: Text(
          text,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onTap;

  const ProfileDetails({
    super.key,
    required this.text,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        onTap: onTap,
        dense: true,
        enabled: true,
        minLeadingWidth: 60,
        leading: Icon(
          iconData,
          color: AppColor.iconColor,
          size: 25,
        ),
        title: Text(
          text,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}






