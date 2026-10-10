import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../painters/terminal_painters.dart';
import '../state/pipboy_state.dart';
import '../widgets/terminal_bar.dart';
import '../widgets/terminal_panel.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key, required this.state});
  final PipBoyState state;

  @override
  Widget build(BuildContext context) => TerminalPanel(
        title: 'STATUS // CONDITION',
        child: ListView(children: [
          Center(
              child: CustomPaint(
                  size: const Size(120, 180),
                  painter: CharacterConditionPainter())),
          Text('LEVEL 12 // WASTELAND EXPLORER', style: PipText.body(context)),
          Text('CONDITION: ${state.condition}', style: PipText.small(context)),
          const SizedBox(height: 12),
          TerminalBar(label: 'HP', value: state.hp / 100),
          Text(
              'HP ${state.hp}/${state.maxHp} // Radiation limits maximum health',
              style: PipText.small(context)),
          TerminalBar(label: 'AP', value: state.ap / 100),
          TerminalBar(label: 'RAD', value: state.rads / 100, warning: true),
          Text('DMG ${state.damage} // DR ${state.defense}',
              style: PipText.body(context)),
          const SizedBox(height: 16),
          Text('S.P.E.C.I.A.L. // POINTS ${state.attributePoints}',
              style: PipText.heading(context)),
          for (final entry in state.special.entries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('${entry.key} ${entry.value}',
                  style: PipText.body(context)),
              subtitle: Text(specialDescriptions[entry.key]!,
                  style: PipText.small(context)),
              trailing: IconButton(
                key: ValueKey('increase-${entry.key}'),
                tooltip: 'Increase ${entry.key}',
                color: PipColors.glowGreen,
                onPressed: state.attributePoints > 0 && entry.value < 10
                    ? () => state.increaseSpecial(entry.key)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ),
        ]),
      );
}
