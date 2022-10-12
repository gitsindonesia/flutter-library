import 'package:flutter/material.dart';

class IconCheckPainter extends CustomPainter {
  final Color iconColor;
  IconCheckPainter({
    required this.iconColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.9166667);
    path_0.cubicTo(
        size.width * 0.2698750,
        size.height * 0.9166667,
        size.width * 0.08333333,
        size.height * 0.7301250,
        size.width * 0.08333333,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.08333333,
        size.height * 0.2698750,
        size.width * 0.2698750,
        size.height * 0.08333333,
        size.width * 0.5000000,
        size.height * 0.08333333);
    path_0.cubicTo(
        size.width * 0.7301250,
        size.height * 0.08333333,
        size.width * 0.9166667,
        size.height * 0.2698750,
        size.width * 0.9166667,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9166667,
        size.height * 0.7301250,
        size.width * 0.7301250,
        size.height * 0.9166667,
        size.width * 0.5000000,
        size.height * 0.9166667);
    path_0.close();
    path_0.moveTo(size.width * 0.4584583, size.height * 0.6666667);
    path_0.lineTo(size.width * 0.7530417, size.height * 0.3720417);
    path_0.lineTo(size.width * 0.6941250, size.height * 0.3131250);
    path_0.lineTo(size.width * 0.4584583, size.height * 0.5488333);
    path_0.lineTo(size.width * 0.3405833, size.height * 0.4309583);
    path_0.lineTo(size.width * 0.2816667, size.height * 0.4898750);
    path_0.lineTo(size.width * 0.4584583, size.height * 0.6666667);
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
