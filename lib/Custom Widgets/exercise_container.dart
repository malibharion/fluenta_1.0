import 'package:fluenta/contants/app_fonts.dart';
import 'package:flutter/material.dart';

class ExerciseContainer extends StatelessWidget {
  final String? text;
  final GestureTapCallback? onTap;
  final double? height;
  final double? width;
  final String? text2;
  const ExerciseContainer({
    this.onTap,
    this.text,
    this.text2,
    this.height,
    this.width,
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text!,
                      style: TextStyle(
                        fontFamily: AppFonts.bold,
                        color: Colors.white,
                        fontSize: width,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),

                    Column(
                      children: [
                        SizedBox(height: screenHeight * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(Icons.play_arrow, color: Colors.black),
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    fontFamily: AppFonts.bold,
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
