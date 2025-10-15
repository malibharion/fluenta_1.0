import 'package:flutter/material.dart';
import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/views/LoginSignup/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
            SizedBox(height: screenHeight * 0.09),
            Image.asset('assets/images/user_2.png', height: screenWidth * 0.4),
            SizedBox(height: screenHeight * 0.05),

            /// White rounded container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
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
                          'Reset Password',
                          style: TextStyle(
                            fontFamily: AppFonts.bold,
                            color: Colors.black,
                            fontSize: screenWidth * 0.07,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        Text(
                          'Enter your new password below to reset your account.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.light,
                            color: Colors.grey[700],
                            fontSize: screenWidth * 0.04,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'New Password',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Enter new password",
                          icon1: Icons.lock,
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          hintText: "Re-enter new password",
                          icon1: Icons.lock_outline,
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        CustomBtn(
                          onPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          text: "Reset Password",
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Back to Login',
                            style: TextStyle(
                              fontFamily: AppFonts.bold,
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
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
