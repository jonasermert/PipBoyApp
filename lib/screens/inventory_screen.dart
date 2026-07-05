import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../widgets/terminal_panel.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TerminalPanel(
      title: 'INVENTORY // ITEMS',
      child: ListView.separated(
        itemCount: inventoryItems.length,
        separatorBuilder: (_, __) => Divider(color: PipColors.glowGreen.withOpacity(.25)),
        itemBuilder: (context, index) {
          final item = inventoryItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text('> ${item.name}', style: PipText.body(context))),
                Expanded(child: Text(item.type, style: PipText.small(context))),
                Expanded(child: Text('VAL ${item.value}', style: PipText.small(context))),
                Expanded(child: Text('WG ${item.weight.toStringAsFixed(1)}', style: PipText.small(context))),
              ],
            ),
          );
        },
      ),
    );
  }
}
