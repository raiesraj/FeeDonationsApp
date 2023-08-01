import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Components/custom_texflied.dart';
import '../Provider/forget_password_provider.dart';
import '../Utilis/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    ForgetPasswordProvider forgetPasswordProvider =
    Provider.of<ForgetPasswordProvider>(context, listen: true);


    bool isEmailSend = false;

    TextEditingController forgetPasswordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  30.ph,
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.glassmorpheiumColor,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  90.ph,
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Reset\nPassword",
                      style: GoogleFonts.lato(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  20.ph,
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Please enter your email address\nto request a password reset." ,
                      style: GoogleFonts.laila(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  50.ph,
                  Padding(
                    padding: const EdgeInsets.only(left: 33),
                    child: Text("Email",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w500),),
                  ),
                  10.ph,
                  CustomTextFiled(
                      controller: forgetPasswordController,
                      hintText: "abc@gmail.com",
                      keyboardType: TextInputType.emailAddress),
                  15.ph,
                  Visibility(
                    visible: forgetPasswordProvider.isEmailSend,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Password reset sent to your email address",style: GoogleFonts.lato(fontSize: 16,color: Colors.green),),
                    ),
                  ),
                  30.ph,
                  Consumer<ForgetPasswordProvider>(
                      builder: (context, passwordFor, _) {
                        return MyButton(
                          onTaP: () {
                            forgetPasswordProvider.forgetPassword(
                                forgetPasswordController: forgetPasswordController,
                                context: context);

                          },
                          title: "Send Reset password",
                          color: AppColor.kButtonColor,
                        );
                      }),
                  //  Spacer(),
                ],
              ),
              Visibility(
                visible: forgetPasswordProvider.isLoading,
                child: Positioned.fill(
                  child: Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.red, size: 45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
