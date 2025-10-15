import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.03),
            // Icon(Icons., color: Colors.white, size: screenWidth * 0.4),
            Image(image: AssetImage('assets/images/user_2.png'), width: 60),
            // Text(
            //   'Sign Up',
            //   style: TextStyle(
            //     fontFamily: AppFonts.bold,
            //     color: Colors.white,
            //     fontSize: screenWidth * 0.1,
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: AppFonts.bold,

                            color: Colors.black,
                            fontSize: screenWidth * 0.07,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'First Name',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Enter your first name",
                          icon1: Icons.person,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Laset Name',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Enter your last name",
                          icon1: Icons.person,
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Email',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Enter your email",
                          icon1: Icons.email,
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Password',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Enter your password",
                          icon1: Icons.password,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        CustomBtn(
                          text: "Sign Up",
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontFamily: AppFonts.regular,
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: AppFonts.bold,
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
