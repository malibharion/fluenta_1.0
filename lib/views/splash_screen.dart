import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluenta/views/LoginSignup/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotIndex = (_dotIndex + 1) % 3;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      _timer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/splash screen (2).png',
              fit: BoxFit.cover,
            ),
          ),
          // Progressive Dots
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _dotIndex == index ? 14 : 8,
                    height: _dotIndex == index ? 14 : 8,
                    decoration: BoxDecoration(
                      color: _dotIndex == index ? Colors.black : Colors.black26,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
