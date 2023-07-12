import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Components/custom_Text.dart';
import '../Components/custom_texflied.dart';
import '../Provider/homescreen_provider.dart';
import '../Utilis/images.dart';

class PostRequestScreen extends StatefulWidget {
  const PostRequestScreen({Key? key}) : super(key: key);

  @override
  State<PostRequestScreen> createState() => _PostRequestScreenState();
}

class _PostRequestScreenState extends State<PostRequestScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController feeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);

    return Scaffold(body: Consumer<HomeScreenProvider>(
        builder: (context, hideAndShowBottomNavigation, _) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                  child: SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      child: homeScreenProvider.profilePic != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                homeScreenProvider.profilePic!,
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages().galleryImg),
                                  10.ph,
                                  const CustomText(
                                    text: "From Gallery",
                                    fontWeight: FontWeight.w400,
                                    textSize: 14,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                  ),
                ),
                homeScreenProvider.myDropDown(),
                20.ph,
                CustomTextFiled(
                  controller: nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.text,
                ),
                CustomTextFiled(
                  controller: feeController,
                  hintText: "Fee",
                  keyboardType: TextInputType.number,
                ),
                20.ph,
                MyButton(
                    onTaP: () {
                      homeScreenProvider.myDropDown();
                      homeScreenProvider.sendData(
                          nameController: nameController,
                          context: context,
                          feeController: feeController);
                    },
                    title: "Submit Form")
              ],
            ),

            ///To show Loading at the Top of the Screen without hide widgets
            Visibility(
                visible: homeScreenProvider.isLoading,
                child: Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(
                        0.5), // A semi-transparent color to dim the screen
                    child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.red, size: 45),
                    ),
                  ),
                ),
            ),
          ],
        ),
      );
    }
    ),
    );
  }
}
