import 'dart:async';
import 'package:flutter/material.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  AnimationController? _progressController;

  final List<String> _reels = [
    'assets/videos/reel1.mp4',
    'assets/videos/reel2.mp4',
    'assets/videos/reel3.mp4',
  ];

  @override
  void initState() {
    super.initState();

    _progressController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _goToNextReel();
            }
          });

    _startTimer();
  }

  void _startTimer() {
    _progressController?.forward(from: 0);
    _timer = Timer(Duration(seconds: 5), _goToNextReel);
  }

  void _goToNextReel() {
    if (_currentPage < _reels.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(0); // Loop back to first reel
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _timer?.cancel();
    _progressController?.stop();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: _onPageChanged,
            itemCount: _reels.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Replace this with your VideoPlayer widget
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Reel ${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Progress bar at top
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: AnimatedBuilder(
              animation: _progressController!,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressController?.value,
                  color: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  minHeight: 4,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
