import 'package:flutter/material.dart';
import 'package:linear_rotation/linear_text.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
   _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final numberOfTexts = 20;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isOnLeft(double rotation) => math.cos(rotation) > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(
            numberOfTexts, (index) {
              return AnimatedBuilder(
                animation: _animationController,
                child: const LinearText(),
                builder: (context, child) {
                  final animationRotationValue = _animationController.value * 2 * math.pi / numberOfTexts;
                  double rotation = 2 * math.pi * index / numberOfTexts + math.pi / 2 + animationRotationValue;
                  if (isOnLeft(rotation)) {
                    rotation = -rotation + 2 * animationRotationValue - math.pi * 2 / numberOfTexts;
                  }
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotation)
                      ..translate(-120.0),
                    child: const LinearText(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}