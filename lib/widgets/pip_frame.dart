import 'package:flutter/material.dart';

import '../core/pip_theme.dart';
import '../painters/crt_painters.dart';

class PipFrame extends StatelessWidget {
  const PipFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [Color(0xFF12351A), PipColors.background, Colors.black],
            ),
          ),
          child: SizedBox.expand(),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .42),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                    color: PipColors.glowGreen.withValues(alpha: .85),
                    width: 2),
                boxShadow: [
                  BoxShadow(
                      color: PipColors.glowGreen.withValues(alpha: .23),
                      blurRadius: 36,
                      spreadRadius: 4),
                  BoxShadow(
                      color: Colors.black.withValues(alpha: .7),
                      blurRadius: 18,
                      spreadRadius: 6),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
        IgnorePointer(
            child:
                CustomPaint(size: Size.infinite, painter: ScanlinePainter())),
        IgnorePointer(
            child: CustomPaint(
                size: Size.infinite, painter: CrtNoisePainter(seed: 7))),
        IgnorePointer(
            child:
                CustomPaint(size: Size.infinite, painter: VignettePainter())),
      ],
    );
  }
}
