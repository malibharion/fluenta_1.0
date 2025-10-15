import 'package:fluenta/Custom%20Widgets/exercise_container.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/views/Main%20Screens/exrecise_screen.dart';
import 'package:flutter/material.dart';

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello Strugler",
          style: TextStyle(fontFamily: "Bold", color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  textAlign: TextAlign.start,
                  'Discover how\nto speak fluently',
                  style: TextStyle(
                    fontFamily: AppFonts.bold,
                    fontSize: screenWidth * 0.07,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
              ExerciseContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseScreen()),
                  );
                },
                width: screenWidth * 0.06,
                text: 'Slow Reading\nExercise',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              ExerciseContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseScreen()),
                  );
                },
                width: screenWidth * 0.06,
                text: 'Breathing Control\nExercise',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              ExerciseContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseScreen()),
                  );
                },
                width: screenWidth * 0.06,
                text: 'Rythmic Speech\nControl',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
              ExerciseContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseScreen()),
                  );
                },
                width: screenWidth * 0.06,
                text: 'Voice Modulation\nExercise',
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
