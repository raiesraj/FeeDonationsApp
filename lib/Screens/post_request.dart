import 'package:feedonations/Constant/sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/custom_Text.dart';
import '../Components/custom_texflied.dart';
import '../Provider/homescreen_provider.dart';
import '../Routes/routes.dart';
import 'Donations.dart';
import 'googlePay.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  TextEditingController name = TextEditingController();


  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          30.ph,
          const CustomText(
              text: "Fill the form to Receive Donations",
              fontWeight: FontWeight.bold,
              textSize: 20),
          30.ph,
          CupertinoButton(
            onPressed: () {
              homeScreenProvider.selectImage(context);
            },
            child: CircleAvatar(
                radius: 50,
                backgroundImage: (homeScreenProvider.profilePic != null)
                    ? FileImage(homeScreenProvider.profilePic!)
                    : null),
          ),
            homeScreenProvider.myDropDown(),
          20.ph,
          CustomTextFiled(controller: name, hintText: "Name"),
          ElevatedButton(
            onPressed: () {
              homeScreenProvider.sendData(nameController: name,);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }
}
