import 'package:fluenta/contants/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final GestureTapCallback? onPress;
  final String? text;

  CustomBtn({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.text,
    this.onPress,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,

      child: Container(
        width: double.infinity,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
              fontFamily: AppFonts.bold,
              color: Colors.white,
              fontSize: screenWidth * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
