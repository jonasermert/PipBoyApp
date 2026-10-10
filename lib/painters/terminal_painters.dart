import 'package:flutter/material.dart';

import '../core/pip_theme.dart';

class WastelandMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = PipColors.glowGreen.withValues(alpha: .24)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final route = Paint()
      ..color = PipColors.phosphor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(24, size.height - 36)
      ..quadraticBezierTo(size.width * .22, size.height * .72, size.width * .42,
          size.height * .58)
      ..lineTo(size.width * .62, size.height * .35)
      ..quadraticBezierTo(
          size.width * .78, size.height * .18, size.width - 38, 44);
    canvas.drawPath(path, route);

    final marker = Paint()..color = PipColors.phosphor;
    canvas.drawCircle(Offset(size.width * .62, size.height * .35), 7, marker);
    canvas.drawCircle(Offset(size.width - 38, 44), 7, marker);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CharacterConditionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = PipColors.phosphor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final glow = Paint()
      ..color = PipColors.glowGreen.withValues(alpha: .18)
      ..strokeWidth = 13
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    void drawBody(Paint p) {
      final cx = size.width / 2;
      canvas.drawCircle(Offset(cx, 28), 20, p);
      canvas.drawLine(Offset(cx, 50), Offset(cx, 112), p);
      canvas.drawLine(Offset(cx, 68), Offset(cx - 48, 94), p);
      canvas.drawLine(Offset(cx, 68), Offset(cx + 48, 94), p);
      canvas.drawLine(Offset(cx, 112), Offset(cx - 36, 170), p);
      canvas.drawLine(Offset(cx, 112), Offset(cx + 36, 170), p);
    }

    drawBody(glow);
    drawBody(line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
