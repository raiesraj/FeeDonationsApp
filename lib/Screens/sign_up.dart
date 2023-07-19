import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/signup_provider.dart';
import 'package:feedonations/Screens/signin_screen.dart';
import 'package:feedonations/Utilis/appText.dart';
import 'package:feedonations/Utilis/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/custom_Text.dart';
import '../Components/custom_texflied.dart';
import '../Components/textfield_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  String?displayName;



  @override
  Widget build(BuildContext context) {
    SignUpAuthProvider signUpAuthProvider =
        Provider.of<SignUpAuthProvider>(context);

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
              const TextFiledTitle(
                title: 'Name',
              ),
              CustomTextFiled(
                keyboardType: TextInputType.name,
                hintText: "Name",
                controller: nameController,
              ),
              const TextFiledTitle(
                title: "Email Id",

              ),
              CustomTextFiled(
                keyboardType: TextInputType.emailAddress,
                hintText: "EmailId",
                controller: emailController,
              ),
              const TextFiledTitle(
                title: "Password",
              ),
              CustomTextFiled(
                keyboardType: TextInputType.phone,
                hintText: 'Password',
                controller: passwordController,
              ),
              28.ph,
              MyButton(
                title: "Sign Up",
                onTaP: () {
                  signUpAuthProvider.signUpValidation(
                      context: context,
                      nameController: nameController,
                      email: emailController,
                      password: passwordController, displayName: nameController.text,
                  );
                },
              ),
              10.ph,
              ImageButton(
                  onTap: () {},
                  signUpAuthProvider: signUpAuthProvider,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController),
              32.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                      text: "Already have an account?\t\t",
                      fontWeight: FontWeight.w400,
                      textSize: 14),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const CustomText(
                        text: "Login",
                        fontWeight: FontWeight.w400,
                        textSize: 14,
                        color: Colors.teal,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final VoidCallback onTap;

  const ImageButton({
    super.key,
    required this.signUpAuthProvider,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
  });

  final SignUpAuthProvider signUpAuthProvider;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 27),
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Image.asset(
                AppImages().googleLogo,
                width: 30,
              ),
              15.pw,
              signUpAuthProvider.loading
                  ? const CircularProgressIndicator()
                  : const Text("SignIn"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final VoidCallback? onTaP;
  final String title;
  final Color? color;

  const MyButton({
    super.key,
    required this.onTaP, required this.title, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTaP,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 27),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child:  Center(
          child: CustomText(
            text: title,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            textSize: 16,
          ),
        ),
      ),
    );
  }
}
