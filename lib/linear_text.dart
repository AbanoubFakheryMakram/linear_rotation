import 'package:flutter/material.dart';

class LinearText extends StatelessWidget {
  const LinearText({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.9),
              Colors.transparent
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.0, 0.2, 0.8],
          ),
        ),
        child: const Text(
          'LINEAR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 110,
          ),
        ),
      ),
    );
  }
}