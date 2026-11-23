import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Approved two-tone swap mark. Coordinates match the selected identity board.
class DalilLogo extends StatelessWidget {
  final double size;
  const DalilLogo({super.key, this.size = 84});
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'دليل',
    image: true,
    child: SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _DalilLogoPainter()),
    ),
  );
}

class _DalilLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 60, size.height / 60);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 60, 60),
        const Radius.circular(18),
      ),
      Paint()..color = AppColors.primary,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.butt;
    canvas.drawPath(
      Path()
        ..moveTo(14, 23)
        ..lineTo(45, 23)
        ..lineTo(38, 16),
      paint..color = Colors.white,
    );
    canvas.drawPath(
      Path()
        ..moveTo(46, 38)
        ..lineTo(15, 38)
        ..lineTo(22, 45),
      paint..color = AppColors.accent,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
