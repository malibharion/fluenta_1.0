import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/services/auth_services.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showMessage("Please enter email & password");
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authServices.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() => _isLoading = false);

    if (result == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      showMessage(result);
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.09),

            /// AnimatedSwitcher for top icon and black area
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isKeyboardOpen
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Image(
                          key: const ValueKey('userIcon'),
                          image: const AssetImage('assets/images/user_2.png'),
                          height: screenHeight * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.05),

                        /// LOGIN TITLE
                        Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: AppFonts.bold,
                            color: Colors.black,
                            fontSize: screenWidth * 0.07,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        /// EMAIL
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
                          controller: emailController,
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
                          controller: passwordController,
                          hintText: "Enter Password",
                          icon1: Icons.password,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ForgotPasswordScreen(),
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

                        SizedBox(height: screenHeight * 0.05),

                        /// LOGIN BUTTON
                        CustomBtn(
                          onPress: _isLoading ? null : handleLogin,
                          text: _isLoading ? "Please wait..." : "Login",
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        /// SIGN UP LINK
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
                                    builder: (_) => SignupScreen(),
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

                        SizedBox(height: screenHeight * 0.05),
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
