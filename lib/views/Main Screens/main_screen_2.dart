import 'package:flutter/material.dart';
import 'package:fluenta/Custom%20Widgets/exercise_container.dart';
import 'package:fluenta/contants/app_fonts.dart';
import 'package:fluenta/views/Main%20Screens/exrecise_screen.dart';

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Hello Struggler 👋",
          style: TextStyle(
            fontFamily: "Bold",
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.transparent,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: const TextStyle(fontFamily: "Bold", fontSize: 16),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: "Regular",
                    fontSize: 15,
                  ),
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.developer_board),
                      text: "Developmental",
                    ),
                    Tab(icon: Icon(Icons.memory), text: "Neurogenic"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExerciseList(context, screenWidth, screenHeight, [
            "Slow Reading\nExercise",
            "Breathing Control\nExercise",
          ]),
          _buildExerciseList(context, screenWidth, screenHeight, [
            "Rhythmic Speech\nControl",
            "Voice Modulation\nExercise",
          ]),
        ],
      ),
    );
  }

  Widget _buildExerciseList(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    List<String> exercises,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover how\nto speak fluently',
              style: TextStyle(
                fontFamily: AppFonts.bold,
                fontSize: screenWidth * 0.07,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            for (var text in exercises) ...[
              ExerciseContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExerciseScreen(),
                    ),
                  );
                },
                width: screenWidth * 0.06,
                text: text,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ],
        ),
      ),
    );
  }
}
