import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/views/LoginSignup/reset_password_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.1),

            Image(
              image: const AssetImage('assets/images/user_2.png'),
              width: screenWidth * 0.5,
              height: screenHeight * 0.25,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 30),

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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.06),

                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: AppFonts.bold,
                          fontSize: screenWidth * 0.07,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),

                      Text(
                        "Don’t worry! Just enter your email below\nand we’ll send you a reset link.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.light,
                          color: Colors.grey[700],
                          fontSize: screenWidth * 0.04,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontFamily: AppFonts.regular,
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      CustomTextFeild(
                        hintText: "Enter your registered email",
                        icon1: Icons.email_outlined,
                      ),

                      SizedBox(height: screenHeight * 0.07),

                      CustomBtn(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen(),
                            ),
                          );
                        },
                        text: "Continue",
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      /// 🔙 Back to Login
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontFamily: AppFonts.bold,
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✉️ Dialog on reset
  void _showResetSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 280,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_rounded,
                size: 60,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "Reset Link Sent!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We’ve sent a password reset link\nto your registered email address.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
