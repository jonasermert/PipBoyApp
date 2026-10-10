import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/pip_theme.dart';
import 'screens/pipboy_home.dart';

void main() {
  runApp(const PipBoyApp());
}

class PipBoyApp extends StatelessWidget {
  const PipBoyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PipBoyApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: PipColors.background,
        colorScheme: const ColorScheme.dark(
          primary: PipColors.glowGreen,
          secondary: PipColors.phosphor,
          surface: PipColors.panelDark,
          onPrimary: PipColors.background,
          onSecondary: PipColors.background,
          onSurface: PipColors.glowGreen,
        ),
        textTheme:
            GoogleFonts.shareTechMonoTextTheme(ThemeData.dark().textTheme),
        splashColor: PipColors.glowGreen.withValues(alpha: .15),
        highlightColor: PipColors.glowGreen.withValues(alpha: .08),
      ),
      home: const PipBoyHome(),
    );
  }
}
