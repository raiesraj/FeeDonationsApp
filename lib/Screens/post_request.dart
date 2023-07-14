import 'package:country_picker/country_picker.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController schoolNameController = TextEditingController();
 TextEditingController countryNameController = TextEditingController();

  Country? selectedCountry;


  @override
  Widget build(BuildContext context) {

    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);

    Future<void> _showImagePickerDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Image'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Gallery'),
                    onTap: () {
                      homeScreenProvider.selectImage(ImageSource.gallery, context);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    child: const Text('Camera'),
                    onTap: () {
                      homeScreenProvider.selectImage(ImageSource.camera, context);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    child: const Text('Remove Image'),
                    onTap: () {
                      homeScreenProvider.removeImage(context);
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Consumer<HomeScreenProvider>(
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
                       _showImagePickerDialog(context);

                    },
                    child: SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      child: homeScreenProvider.profilePic != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                homeScreenProvider.profilePic!,
                                fit: BoxFit.fill,
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
                  CustomTextFiled(controller: countryNameController, hintText: "Select Country", keyboardType: TextInputType.none,
                  showCursor: false,
                  suffixIcon: Icons.arrow_drop_down,
                    onTap: (){
                      showCountryPicker(
                        showPhoneCode: false,
                        showWorldWide: false,
                        context: context, onSelect: (Country country) {
                        setState(() {
                          selectedCountry = country;
                          countryNameController.text = country.name;
                        });
                      },
                      );
                    },
                  ),
                  CustomTextFiled(
                    controller: schoolNameController,
                    hintText: "Institute",
                    keyboardType: TextInputType.name,
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
                            schoolNameController: schoolNameController,
                            nameController: nameController,
                            context: context,
                            feeController: feeController, countryNameController: countryNameController);
                      },
                      title: "Submit Form")
                ],
              ),




              ///To show Loading at the Top of the Screen without hide widgets
              Visibility(
                visible: homeScreenProvider.isLoading,
                child: Positioned.fill(
                  child: Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.red, size: 45),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}







