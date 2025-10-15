import 'package:fluenta/contants/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String? hintText;
  final IconData? icon1;
  final controller;

  CustomTextFeild({this.hintText, this.icon1, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon1, color: Colors.grey[200]),
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: AppFonts.light, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
