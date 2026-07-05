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
        DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [Color(0xFF12351A), PipColors.background, Colors.black],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.42),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: PipColors.glowGreen.withOpacity(.85), width: 2),
                boxShadow: [
                  BoxShadow(color: PipColors.glowGreen.withOpacity(.23), blurRadius: 36, spreadRadius: 4),
                  BoxShadow(color: Colors.black.withOpacity(.7), blurRadius: 18, spreadRadius: 6),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
        IgnorePointer(child: CustomPaint(size: Size.infinite, painter: ScanlinePainter())),
        IgnorePointer(child: CustomPaint(size: Size.infinite, painter: CrtNoisePainter(seed: 7))),
        IgnorePointer(child: CustomPaint(size: Size.infinite, painter: VignettePainter())),
      ],
    );
  }
}
