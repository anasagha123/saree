// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Corner { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT }

class TrianglePainter extends CustomPainter {
  final Color color;
  final Corner corner;

  TrianglePainter({required this.color, required this.corner});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    switch (corner) {
      case Corner.TOP_LEFT:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(0, size.height);
        break;
      case Corner.TOP_RIGHT:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, 0);
        break;
      case Corner.BOTTOM_LEFT:
        path.moveTo(0, size.height);
        path.lineTo(0, 0);
        path.lineTo(size.width, size.height);
        break;
      case Corner.BOTTOM_RIGHT:
        path.moveTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.lineTo(size.width, 0);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}