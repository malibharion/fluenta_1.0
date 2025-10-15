import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/views/LoginSignup/forgot_password_screen.dart';
import 'package:fluenta/views/LoginSignup/signup_screen.dart';
import 'package:fluenta/views/Main%20Screens/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            // Icon(Icons.person, color: Colors.white, size: screenWidth * 0.4),
            Image(image: AssetImage('assets/images/user_2.png')),
            SizedBox(height: screenHeight * 0.05),
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
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        'Login',
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
                          'Email',
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
                          'Password',
                          style: TextStyle(
                            fontFamily: AppFonts.regular,
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      CustomTextFeild(
                        hintText: "Enter Password",
                        icon1: Icons.password,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: AppFonts.light,
                              color: Colors.grey,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.09),
                      CustomBtn(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        text: "Login",
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: AppFonts.bold,
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ],
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
}
