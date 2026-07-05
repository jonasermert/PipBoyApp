import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../painters/terminal_painters.dart';
import '../widgets/status_chip.dart';
import '../widgets/terminal_bar.dart';
import '../widgets/terminal_panel.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'STATUS // CONDITION',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CustomPaint(size: const Size(160, 190), painter: CharacterConditionPainter())),
            const SizedBox(height: 18),
            const TerminalBar(label: 'HP', value: .82),
            const TerminalBar(label: 'AP', value: .64),
            const TerminalBar(label: 'RAD', value: .18, warning: true),
            const TerminalBar(label: 'CND', value: .91),
            const SizedBox(height: 16),
            Text('S.P.E.C.I.A.L.', style: PipText.heading(context)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: specialStats.entries.map((entry) => StatusChip(label: entry.key, value: entry.value)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
