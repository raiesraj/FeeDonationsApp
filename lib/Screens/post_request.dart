import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/university_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/custom_Text.dart';
import '../Components/custom_texflied.dart';
import '../Provider/homescreen_provider.dart';


class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  TextEditingController nameController = TextEditingController();




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
            child:



            CircleAvatar(
                radius: 50,
                backgroundImage: (homeScreenProvider.profilePic != null)
                    ? FileImage(homeScreenProvider.profilePic!)
                    : null),
          ),


           homeScreenProvider.myDropDown(),


          20.ph,
          CustomTextFiled(controller: nameController, hintText: "Name"),
          ElevatedButton(
            onPressed: () {
              //homeScreenProvider.selectImage(context);
             homeScreenProvider.myDropDown();
              homeScreenProvider.sendData(nameController: nameController,context: context);

            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }
}
