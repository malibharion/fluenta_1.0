import 'package:flutter/material.dart';
import 'package:fluenta/Custom Widgets/custom_button.dart';
import 'package:fluenta/views/Main Screens/main_screen_2.dart';
import 'package:video_player/video_player.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool isAvatarPlaying = false;

  late AnimationController _controller;
  late VideoPlayerController _videoController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/videoAvatar.mp4')
          ..initialize().then((_) {
            setState(() {});
          });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scaleAnimation = Tween(
      begin: 1.0,
      end: 1.06,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween(
      begin: 0.2,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _videoController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void toggleAvatar() {
    if (isAvatarPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    setState(() => isAvatarPlaying = !isAvatarPlaying);
  }

  void toggleRecording() {
    setState(() => isRecording = !isRecording);

    if (isRecording) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

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
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Fluenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About Us"),
              ),
              const ListTile(
                leading: Icon(Icons.question_answer_outlined),
                title: Text("FAQ"),
              ),
              const ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
              const Spacer(),
              const Text("Version 1.0.0"),
            ],
          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.01),

              /// 🔹 Heading
              Text(
                "Record, Analyze",
                style: TextStyle(
                  fontFamily: 'Bold',
                  fontSize: w * 0.09,
                  color: Colors.black,
                ),
              ),
              Text(
                "and Test your speech",
                style: TextStyle(
                  fontFamily: 'Bold',
                  fontSize: w * 0.085,
                  color: Colors.grey[700],
                ),
              ),

              SizedBox(height: h * 0.02),

              if (_videoController.value.isInitialized)
                Center(
                  child: GestureDetector(
                    onTap: toggleAvatar,
                    child: Container(
                      height: h * 0.23,
                      width: w * 0.65,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                          Container(color: Colors.black.withOpacity(0.15)),
                        ],
                      ),
                    ),
                  ),
                ),

              SizedBox(height: h * 0.2),

              Center(
                child: GestureDetector(
                  onTap: toggleRecording,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final scale = isRecording ? _scaleAnimation.value : 1.0;
                      final glow = isRecording ? _glowAnimation.value : 0.0;

                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 95,
                          height: 95,
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
                                      blurRadius: 25,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : [
                                    const BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 7,
                                    ),
                                  ],
                          ),
                          child: Icon(
                            isRecording ? Icons.stop : Icons.mic,
                            size: 40,
                            color: isRecording ? Colors.white : Colors.black87,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isRecording ? 1 : 0,
                child: const Center(
                  child: Text(
                    "Listening...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              /// 🔹 Start Exercise Button
              CustomBtn(
                text: "Start Exercise",
                screenHeight: h,
                screenWidth: w,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen2()),
                  );
                },
              ),

              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
