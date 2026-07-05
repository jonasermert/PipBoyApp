import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../widgets/terminal_panel.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'DATA // QUESTS',
      child: ListView.separated(
        itemCount: quests.length,
        separatorBuilder: (_, __) => Divider(color: PipColors.glowGreen.withOpacity(.25)),
        itemBuilder: (context, index) {
          final quest = quests[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${quest.active ? '[ACTIVE]' : '[LOG]'} ${quest.title}', style: PipText.body(context)),
                const SizedBox(height: 6),
                Text(quest.objective, style: PipText.small(context)),
              ],
            ),
          );
        },
      ),
    );
  }
}
