import 'package:flutter/material.dart';

import '../core/pip_theme.dart';

class TerminalBar extends StatelessWidget {
  const TerminalBar({super.key, required this.label, required this.value, this.warning = false});

  final String label;
  final double value;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final color = warning ? PipColors.amber : PipColors.glowGreen;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 64, child: Text(label, style: PipText.body(context))),
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(border: Border.all(color: color.withOpacity(.8))),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: value.clamp(0, 1),
                child: Container(color: color.withOpacity(.74)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text('${(value * 100).round().toString().padLeft(3, '0')}%', style: PipText.small(context)),
        ],
      ),
    );
  }
}
