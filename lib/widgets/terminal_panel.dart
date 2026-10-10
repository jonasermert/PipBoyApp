import 'package:flutter/material.dart';

import '../core/pip_theme.dart';

class TerminalPanel extends StatelessWidget {
  const TerminalPanel({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(title),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PipColors.panelDark.withValues(alpha: .76),
        border: Border.all(color: PipColors.glowGreen.withValues(alpha: .72)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: PipText.heading(context)),
            Divider(
                color: PipColors.glowGreen.withValues(alpha: .75), height: 24),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
