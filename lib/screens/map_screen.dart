import 'package:flutter/material.dart';

import '../core/pip_theme.dart';
import '../painters/terminal_painters.dart';
import '../widgets/terminal_panel.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'MAP // LOCAL AREA',
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: WastelandMapPainter())),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.55),
                border: Border.all(color: PipColors.glowGreen.withOpacity(.7)),
              ),
              child: Text('▲ CURRENT POSITION\nGRID 7B // SIGNAL WEAK', textAlign: TextAlign.center, style: PipText.body(context)),
            ),
          ),
        ],
      ),
    );
  }
}
