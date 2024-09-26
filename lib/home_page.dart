import 'package:flutter/material.dart';
import 'package:linear_rotation/linear_text.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _transformZAnimationController;
  late AnimationController _sizeAnimationController;
  late Animation<double> animation;
  late Animation<double> sizeAnimation;
  final numberOfTexts = 20;

  Duration animationDuration = const Duration(milliseconds: 900);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    )..repeat();

    _transformZAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _sizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    animation = Tween<double>(begin: -2, end: 0).animate(_transformZAnimationController);
    sizeAnimation = Tween<double>(begin: 0, end: 120).animate(_sizeAnimationController);
  }

  @override
  void dispose() {
    _transformZAnimationController.dispose();
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
            numberOfTexts,
            (index) {
              return AnimatedBuilder(
                animation: _transformZAnimationController,
                builder: (context, child) {
                  return ScaleTransition(
                    scale: _transformZAnimationController,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0001)
                        ..rotateX(animation.value * 1),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        child: LinearText(
                          fontSize: sizeAnimation.value,
                        ),
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
                            child: child,
                          );
                        },
                      ),
                    ),
                  );
                }
              );
            },
          ),
        ),
      ),
    );
  }
}
