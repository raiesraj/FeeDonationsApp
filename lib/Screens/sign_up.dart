import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/signup_provider.dart';
import 'package:feedonations/Utilis/appText.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../Components/custom_Text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    SignUpAuthProvider signUpAuthProvider = Provider.of<SignUpAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.ph,
              Center(
                child: Image.asset(AppImages().appLogo),
              ),
              23.ph,
              Center(
                child: CustomText(
                  text: AppText().createText,
                  fontWeight: FontWeight.w400,
                  textSize: 28,
                ),
              ),
              6.ph,
              Center(
                child: CustomText(
                    text: AppText().startY,
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                ),
              ),
              21.ph,
              const TextFiledTitle(title: 'Name',),
               CustomTextFiled(
                 controller: nameController,
               ),
              const TextFiledTitle(
                title: "Email Id",
              ),
               CustomTextFiled(
                controller: emailController,
              ),
              const TextFiledTitle(
                title: "Password",
              ),
                CustomTextFiled(
                 controller: passwordController,
               ),
                28.ph,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 27),
                height: 48,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: CustomText(
                    text: "Sign Up",
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    textSize: 16,
                  ),
                ),
              ),
              10.ph,
              InkWell(
                onTap: (){
                  signUpAuthProvider.signUpValidation(context: context, name: nameController, email: emailController, password: passwordController);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 27),
                  height: 48,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.blueAccent,width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:  Center(
                    child: Row(
                      children: [
                        const Spacer(),
                        Image.asset(AppImages().appLogo,width: 30,),
                        15.pw,
                        signUpAuthProvider.loading ? CircularProgressIndicator() : Text("Sigin"),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFiledTitle extends StatelessWidget {
  final String title;
  const TextFiledTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 27),
      child: CustomText(text: title, fontWeight: FontWeight.w400, textSize: 14,color: Colors.black),
    );
  }
}

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextFiled({
    super.key, required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27,vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Name",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
