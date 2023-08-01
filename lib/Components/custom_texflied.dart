

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
    Function(String)?onChanged;
  final bool? showCursor;

   CustomTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.showCursor,
     this.onChanged
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 0),
      child: TextFormField(
        onChanged: widget.onChanged,
        showCursor: widget.showCursor,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: widget.hintText,
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
