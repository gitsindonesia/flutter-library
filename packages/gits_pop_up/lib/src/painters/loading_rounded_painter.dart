import 'package:flutter/material.dart';

class LoadingRoundedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(21.5206, 28.3808);
    path_0.cubicTo(19.1555, 32.0287, 17.8583, 36.2607, 17.7748, 40.6016);
    path_0.cubicTo(17.6913, 44.9426, 18.8248, 49.2208, 21.0479, 52.9562);
    path_0.cubicTo(23.2711, 56.6915, 26.496, 59.7362, 30.3607, 61.7485);
    path_0.cubicTo(34.2254, 63.7607, 38.577, 64.6609, 42.927, 64.3481);
    path_0.cubicTo(47.2771, 64.0352, 51.4535, 62.5217, 54.9875, 59.9774);
    path_0.cubicTo(58.5216, 57.433, 61.2734, 53.9585, 62.9341, 49.9438);
    path_0.cubicTo(64.5948, 45.9292, 65.0988, 41.5332, 64.3894, 37.2492);
    path_0.cubicTo(63.68, 32.9653, 61.7853, 28.9629, 58.918, 25.6913);

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06024096;
    paint0Stroke.color = const Color(0xffF2F2F2).withOpacity(1.0);
    paint0Stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(35.0291, 63.5776);
    path_1.cubicTo(39.2352, 64.7258, 43.6796, 64.6844, 47.8634, 63.458);
    path_1.cubicTo(52.0472, 62.2315, 55.8048, 59.8687, 58.7146, 56.6345);
    path_1.cubicTo(61.6245, 53.4003, 63.5713, 49.4228, 64.3366, 45.1484);
    path_1.cubicTo(65.1019, 40.874, 64.6554, 36.4718, 63.0473, 32.436);
    path_1.cubicTo(61.4391, 28.4002, 58.733, 24.8903, 55.2325, 22.3005);
    path_1.cubicTo(51.732, 19.7106, 47.5757, 18.1431, 43.2301, 17.774);
    path_1.cubicTo(38.8845, 17.4048, 34.5215, 18.2486, 30.6308, 20.2107);
    path_1.cubicTo(26.7401, 22.1727, 23.4758, 25.1754, 21.204, 28.8816);

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06024096;
    paint1Stroke.color = const Color(0xffF67F40).withOpacity(1.0);
    paint1Stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_1, paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
