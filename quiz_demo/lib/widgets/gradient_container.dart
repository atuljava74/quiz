import 'package:flutter/material.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/util.dart';

class GradientCardWithBubble extends StatelessWidget {
  final Widget child;

  GradientCardWithBubble({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary],
          // colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20, // Adjust the left position as needed
            top: -20, // Adjust the top position as needed
            child: CustomPaint(
              painter: BubblePainter(Alignment.topLeft),
            ),
          ),
          Positioned(
            right: -20, // Adjust the right position as needed
            bottom: -20, // Adjust the bottom position as needed
            child: CustomPaint(
              painter: BubblePainter(Alignment.bottomRight),
            ),
          ),
          Center(
            child: Container(
              padding: getPadding(all: 10),
              child: child,
            ),
          ), // Center the child widget within the Stack
        ],
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final Alignment alignment;

  BubblePainter(this.alignment);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final double radius = 50; // Adjust the radius as needed
    final Offset center = alignment == Alignment.topLeft
        ? Offset(radius, radius)
        : Offset(size.width - radius, size.height - radius);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
