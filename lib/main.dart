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
        textTheme: GoogleFonts.shareTechMonoTextTheme(ThemeData.dark().textTheme),
        splashColor: PipColors.glowGreen.withOpacity(.15),
        highlightColor: PipColors.glowGreen.withOpacity(.08),
      ),
      home: const PipBoyHome(),
    );
  }
}
