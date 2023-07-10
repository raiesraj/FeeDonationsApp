import 'package:feedonations/Components/custom_texflied.dart';
import 'package:feedonations/Components/textfield_title.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/signin_provider.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:feedonations/Utilis/appText.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Components/custom_Text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SignInProviderAuth signInProviderAuth =
        Provider.of<SignInProviderAuth>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(AppImages().appLogo),
              ),
              20.ph,
              Center(
                child: CustomText(
                  text: AppText().logIn,
                  fontWeight: FontWeight.w400,
                  textSize: 28,
                ),
              ),
              20.ph,
              Center(
                child: CustomText(
                  text: AppText().welcomeTex,
                  fontWeight: FontWeight.w400,
                  textSize: 16,
                ),
              ),
              const TextFiledTitle(title: "EmailId"),
              CustomTextFiled(controller: emailController,hintText: "EmailId",keyboardType: TextInputType.emailAddress,),
              const TextFiledTitle(title: "Password"),
              CustomTextFiled(
                keyboardType: TextInputType.phone,
                hintText: "Password",
                controller: passwordController,
              ),
              30.ph,
              MyButton(
                title: "LogIn",
                  onTaP: (){
                    signInProviderAuth.signInValidation(
                      context: context,
                        email: emailController, password: passwordController);
                  }
              ),
              20.ph,
              Center(
                child: Container(
                  child: signInProviderAuth.loading ? LoadingAnimationWidget.horizontalRotatingDots(color: Colors.red, size: 30): null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
