import 'package:flutter/material.dart';

class IconInfoPainter extends CustomPainter {
  final Color iconColor;
  IconInfoPainter({
    required this.iconColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.fillType = PathFillType.evenOdd;
    path_0.moveTo(10, 0);
    path_0.cubicTo(4.48, 0, 0, 4.48, 0, 10);
    path_0.cubicTo(0, 15.52, 4.48, 20, 10, 20);
    path_0.cubicTo(15.52, 20, 20, 15.52, 20, 10);
    path_0.cubicTo(20, 4.48, 15.52, 0, 10, 0);
    path_0.close();
    path_0.moveTo(10, 10.9998);
    path_0.cubicTo(9.45, 10.9998, 9, 10.5498, 9, 9.99984);
    path_0.lineTo(9, 5.99984);
    path_0.cubicTo(9, 5.44984, 9.45, 4.99984, 10, 4.99984);
    path_0.cubicTo(10.55, 4.99984, 11, 5.44984, 11, 5.99984);
    path_0.lineTo(11, 9.99984);
    path_0.cubicTo(11, 10.5498, 10.55, 10.9998, 10, 10.9998);
    path_0.close();
    path_0.moveTo(9, 13.0002);
    path_0.lineTo(9, 15.0002);
    path_0.lineTo(11, 15.0002);
    path_0.lineTo(11, 13.0002);
    path_0.lineTo(9, 13.0002);
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
