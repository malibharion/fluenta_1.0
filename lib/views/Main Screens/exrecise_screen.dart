import 'dart:async';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();

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
    _controller.dispose();
    progressTimer?.cancel();
    super.dispose();
  }

  void toggleRecording() {
    if (showResult) return; // Disable after showing result

    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      _controller.repeat(reverse: true);
      _startProgress();
    } else {
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
              /// 🎤 Glowing Recording Button
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
              AnimatedOpacity(
                opacity: isRecording ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 250 * progressValue,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.purpleAccent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${(progressValue * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

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

  /// 🎯 Result Dialog
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
