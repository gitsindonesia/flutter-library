import 'package:flutter/material.dart';

class IconClosePainter extends CustomPainter {
  final Color iconColor;
  IconClosePainter({
    required this.iconColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5884000, size.height * 0.5000128);
    path_0.lineTo(size.width * 0.8554944, size.height * 0.2329211);
    path_0.lineTo(size.width * 0.9105722, size.height * 0.1778417);
    path_0.cubicTo(
        size.width * 0.9187000,
        size.height * 0.1697161,
        size.width * 0.9187000,
        size.height * 0.1565128,
        size.width * 0.9105722,
        size.height * 0.1483872);
    path_0.lineTo(size.width * 0.8516389, size.height * 0.08945333);
    path_0.cubicTo(
        size.width * 0.8435111,
        size.height * 0.08132833,
        size.width * 0.8303111,
        size.height * 0.08132833,
        size.width * 0.8221833,
        size.height * 0.08945333);
    path_0.lineTo(size.width * 0.5000128, size.height * 0.4116250);
    path_0.lineTo(size.width * 0.1778417, size.height * 0.08942722);
    path_0.cubicTo(
        size.width * 0.1697161,
        size.height * 0.08130222,
        size.width * 0.1565128,
        size.height * 0.08130222,
        size.width * 0.1483872,
        size.height * 0.08942722);
    path_0.lineTo(size.width * 0.08942722, size.height * 0.1483617);
    path_0.cubicTo(
        size.width * 0.08130222,
        size.height * 0.1564867,
        size.width * 0.08130222,
        size.height * 0.1696900,
        size.width * 0.08942722,
        size.height * 0.1778156);
    path_0.lineTo(size.width * 0.4116250, size.height * 0.5000128);
    path_0.lineTo(size.width * 0.08942722, size.height * 0.8221833);
    path_0.cubicTo(
        size.width * 0.08130222,
        size.height * 0.8303111,
        size.width * 0.08130222,
        size.height * 0.8435111,
        size.width * 0.08942722,
        size.height * 0.8516389);
    path_0.lineTo(size.width * 0.1483617, size.height * 0.9105722);
    path_0.cubicTo(
        size.width * 0.1564867,
        size.height * 0.9187000,
        size.width * 0.1696900,
        size.height * 0.9187000,
        size.width * 0.1778156,
        size.height * 0.9105722);
    path_0.lineTo(size.width * 0.5000128, size.height * 0.5884000);
    path_0.lineTo(size.width * 0.7671056, size.height * 0.8554944);
    path_0.lineTo(size.width * 0.8221833, size.height * 0.9105722);
    path_0.cubicTo(
        size.width * 0.8303111,
        size.height * 0.9187000,
        size.width * 0.8435111,
        size.height * 0.9187000,
        size.width * 0.8516389,
        size.height * 0.9105722);
    path_0.lineTo(size.width * 0.9105722, size.height * 0.8516389);
    path_0.cubicTo(
        size.width * 0.9187000,
        size.height * 0.8435111,
        size.width * 0.9187000,
        size.height * 0.8303111,
        size.width * 0.9105722,
        size.height * 0.8221833);
    path_0.lineTo(size.width * 0.5884000, size.height * 0.5000128);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = iconColor.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
