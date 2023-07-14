import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
 final bool ? showCursor;

  const CustomTextFiled({
    super.key, required this.controller, required this.hintText, required this.keyboardType,  this.suffixIcon, this.onTap, this.showCursor,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27,vertical: 5),
      child: TextFormField(
        showCursor: showCursor,
        onTap: onTap,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(

          hintText: hintText,
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
