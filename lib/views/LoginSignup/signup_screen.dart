import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/Custom%20Widgets/custom_text_feild.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/services/auth_services.dart';
import 'package:fluenta/views/LoginSignup/login_screen.dart';
import 'package:fluenta/views/Main%20Screens/main_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  Future<void> handleSignup() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showMessage("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authServices.signUp(
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
            SizedBox(height: screenHeight * 0.03),

            /// AnimatedSwitcher for top icon
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isKeyboardOpen
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Image(
                          key: const ValueKey('userIcon'),
                          image: const AssetImage('assets/images/user_2.png'),
                          width: 80,
                          height: screenHeight * 0.15,
                        ),
                        SizedBox(height: screenHeight * 0.02),
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
                          controller: firstNameController,
                          hintText: "Enter your first name",
                          icon1: Icons.person,
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Last Name',
                            style: TextStyle(
                              fontFamily: AppFonts.regular,
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFeild(
                          controller: lastNameController,
                          hintText: "Enter your last name",
                          icon1: Icons.person,
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

                        /// PASSWORD
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
                          hintText: "Enter your password",
                          icon1: Icons.password,
                        ),
                        SizedBox(height: screenHeight * 0.05),

                        CustomBtn(
                          onPress: _isLoading ? null : handleSignup,
                          text: _isLoading ? "Please wait..." : "Sign Up",
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login',
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
