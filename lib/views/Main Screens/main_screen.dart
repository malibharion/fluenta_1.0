import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluenta/Custom%20Widgets/custom_button.dart';
import 'package:fluenta/views/Main%20Screens/main_screen_2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 0.2,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        // ✅ Drawer Section
        drawer: Drawer(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.deepPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Fluenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.black87),
                title: const Text(
                  "About Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("About Fluenta"),
                      content: const Text(
                        "Fluenta helps you improve your speech, practice exercises, and gain confidence.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.question_answer_outlined,
                  color: Colors.black87,
                ),
                title: const Text(
                  "FAQ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Frequently Asked Questions"),
                      content: const Text(
                        "Q: How do I use Fluenta?\nA: Just tap the mic to start recording and analyze your speech.\n\nQ: Is it free?\nA: Yes!",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black87),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out successfully.")),
                  );
                },
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
        ),

        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.05),
                  Text(
                    'Record ',
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: screenWidth * 0.10,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ', Analyze ',
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: screenWidth * 0.10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.05),
                  Text(
                    '& ',
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: screenWidth * 0.10,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Test your speech',
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: screenWidth * 0.09,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),

              //  Animated Mic Button
              GestureDetector(
                onTap: toggleRecording,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final scale = isRecording ? _scaleAnimation.value : 1.0;
                    final glow = isRecording ? _glowAnimation.value : 0.0;

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isRecording
                                ? [
                                    Colors.blueAccent.withOpacity(0.9),
                                    Colors.purpleAccent.withOpacity(0.9),
                                  ]
                                : [Colors.white, Colors.white70],
                          ),
                          boxShadow: isRecording
                              ? [
                                  BoxShadow(
                                    color: Colors.purpleAccent.withOpacity(
                                      glow,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 8,
                                  ),
                                ]
                              : [
                                  const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                  ),
                                ],
                        ),
                        child: Icon(
                          isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                          size: 70,
                          color: isRecording ? Colors.white : Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isRecording ? 1.0 : 0.0,
                child: const Text(
                  "Listening...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),

      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: CustomBtn(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen2(),
                      ),
                    );
                  },
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  text: 'Start Exercise',
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
