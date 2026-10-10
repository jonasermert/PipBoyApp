import 'package:flutter/material.dart';

class PipColors {
  static const background = Color(0xFF020602);
  static const panel = Color(0xFF061409);
  static const panelDark = Color(0xFF030B04);
  static const glowGreen = Color(0xFF41FF68);
  static const phosphor = Color(0xFF9CFFAA);
  static const dimGreen = Color(0xFF1FA83B);
  static const amber = Color(0xFFFFC857);
  static const danger = Color(0xFFFF5F56);

  static List<Shadow> get textGlow => [
        Shadow(color: glowGreen.withValues(alpha: .75), blurRadius: 12),
        Shadow(color: glowGreen.withValues(alpha: .45), blurRadius: 24),
      ];
}

class PipText {
  static TextStyle heading(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            color: PipColors.phosphor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: PipColors.textGlow,
          );

  static TextStyle body(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: PipColors.glowGreen,
            height: 1.35,
            letterSpacing: .8,
            shadows: PipColors.textGlow,
          );

  static TextStyle small(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            color: PipColors.glowGreen.withValues(alpha: .86),
            letterSpacing: .8,
            shadows: PipColors.textGlow,
          );
}
