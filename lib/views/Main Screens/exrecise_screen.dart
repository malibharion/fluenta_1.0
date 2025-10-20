import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with TickerProviderStateMixin {
  bool isRecording = false;
  bool showResult = false;
  double progressValue = 0.0;
  Timer? progressTimer;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // _videoController =
    //     VideoPlayerController.asset('assets/videos/videoAvatar.mp4')
    //       ..initialize().then((_) {
    //         _videoController.setLooping(true);
    //         _videoController.play();
    //         setState(() {});
    //       });
    // _videoController =
    //     VideoPlayerController.asset('assets/videos/videoAvatar.mp4')
    //       ..initialize().then((_) {
    //         _videoController.setLooping(true);
    //         setState(() {});
    //       });
    _videoController =
        VideoPlayerController.asset('assets/videos/videoAvatar.mp4')
          ..initialize().then((_) {
            _videoController.setLooping(true);
            _videoController.pause();
            setState(() {});
          });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

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
  @override
  void dispose() {
    _videoController.pause();
    _videoController.dispose();
    _controller.dispose();
    progressTimer?.cancel();
    super.dispose();
  }

  // void toggleRecording() {
  //   if (showResult) return;

  //   setState(() {
  //     isRecording = !isRecording;
  //   });

  //   if (isRecording) {
  //     _controller.repeat(reverse: true);
  //     _startProgress();
  //   } else {
  //     _controller.stop();
  //     _resetProgress();
  //   }
  // }
  // void toggleRecording() {
  //   if (showResult) return;

  //   setState(() {
  //     isRecording = !isRecording;
  //   });

  //   if (isRecording) {
  //     _videoController.play(); 
  //     _controller.repeat(reverse: true);
  //     _startProgress();
  //   } else {
  //     _videoController.pause(); // ⏸ Pause video
  //     _controller.stop();
  //     _resetProgress();
  //   }
  // }
  void toggleRecording() {
    if (showResult) return;

    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _videoController.play(); // ▶️ Play video
      _controller.repeat(reverse: true);
      _startProgress();
    } else {
      _videoController.pause(); // ⏸ Pause video
      _controller.stop();
      _resetProgress();
    }
  }

  void _startProgress() {
    progressValue = 0;
    progressTimer?.cancel();
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (progressValue < 1.0) {
          progressValue += 0.02; // fills in about 5 seconds
        } else {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 600), () {
            setState(() {
              isRecording = false;
              showResult = true; // Show "View Result" button
            });
          });
        }
      });
    });
  }

  void _resetProgress() {
    progressTimer?.cancel();
    setState(() {
      progressValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_videoController.value.isInitialized)
                AnimatedOpacity(
                  opacity: isRecording ? 1.0 : 0.4,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
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

              SizedBox(height: screenHeight * 0.04),

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
                                    color: Colors.blueAccent.withOpacity(
                                      glow * 0.9,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 8,
                                  ),
                                ]
                              : [
                                  const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 15,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                        ),
                        child: Icon(
                          isRecording
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          size: 70,
                          color: isRecording ? Colors.white : Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              /// 🔤 Status Text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  isRecording
                      ? "Listening..."
                      : showResult
                      ? "Exercise Completed"
                      : "Start Exercise",
                  key: ValueKey(isRecording),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              /// 🎚️ Progress Bar

              /// 🟣 View Result Button (shows after completion)
              if (showResult) ...[
                SizedBox(height: screenHeight * 0.08),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: Colors.purpleAccent.withOpacity(0.5),
                  ),
                  onPressed: () {
                    _showResultDialog(context);
                  },
                  child: const Text(
                    "View Result",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }


  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Result",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 0.85),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, _) => Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.purpleAccent,
                          ),
                        ),
                      ),
                      Text(
                        "${(value * 100).toInt()}%",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "AI Analysis Complete\nGreat Progress 🔥",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
