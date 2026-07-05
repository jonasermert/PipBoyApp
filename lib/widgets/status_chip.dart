import 'package:flutter/material.dart';

import '../core/pip_theme.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: PipColors.glowGreen.withOpacity(.8))),
      child: Column(
        children: [
          Text(label, style: PipText.small(context)),
          const SizedBox(height: 4),
          Text(value.toString().padLeft(2, '0'), style: PipText.heading(context)),
        ],
      ),
    );
  }
}
