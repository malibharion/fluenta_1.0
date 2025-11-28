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
  void dispose() {
    _videoController.pause();
    _videoController.dispose();
    _controller.dispose();
    progressTimer?.cancel();
    super.dispose();
  }

  void toggleRecording() {
    if (showResult) return;

    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _videoController.play();
      _controller.repeat(reverse: true);
      _startProgress();
    } else {
      _videoController.pause();
      _controller.stop();
      _resetProgress();
    }
  }

  void _startProgress() {
    progressValue = 0;
    progressTimer?.cancel();

    progressTimer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      setState(() {
        if (progressValue < 1.0) {
          progressValue += 0.015;
        } else {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              isRecording = false;
              showResult = true;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Video Avatar -------------------------------------------------
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: _videoController.value.isInitialized
                    ? AnimatedOpacity(
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
                      )
                    : const SizedBox.shrink(),
              ),
            ),

            // Bottom Controls -----------------------------------------------
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress Bar -----------------------------------------
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 12,
                      width: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 260 * progressValue,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.purpleAccent,
                                  Colors.blueAccent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Main Start/Stop Button -------------------------------
                    GestureDetector(
                      onTap: toggleRecording,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final scale = isRecording
                              ? _scaleAnimation.value
                              : 1.0;
                          final glow = isRecording ? _glowAnimation.value : 0.0;

                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 110,
                              height: 110,
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
                                size: 50,
                                color: isRecording
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Status or View Result -------------------------------
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: showResult
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () => _showResultDialog(context),
                              child: const Text(
                                "View Result",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : Text(
                              isRecording ? "Listening..." : "Start Exercise",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            width: 280,
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
                const SizedBox(height: 20),

                // Animated result progress
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
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "AI Analysis Complete\nGreat Progress!",
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
