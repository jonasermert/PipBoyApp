import 'package:flutter/material.dart';

import '../core/pip_theme.dart';
import '../widgets/pip_frame.dart';
import 'data_screen.dart';
import 'inventory_screen.dart';
import 'map_screen.dart';
import 'radio_screen.dart';
import 'stat_screen.dart';

class PipBoyHome extends StatefulWidget {
  const PipBoyHome({super.key});

  @override
  State<PipBoyHome> createState() => _PipBoyHomeState();
}

class _PipBoyHomeState extends State<PipBoyHome> {
  static const tabs = ['STAT', 'INV', 'DATA', 'MAP', 'RADIO'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PipFrame(
        child: Column(
          children: [
            Text('ROBCO-TYPE PERSONAL TERMINAL // MODEL 3000', style: PipText.small(context)),
            const SizedBox(height: 12),
            _TabBar(tabs: tabs, selectedIndex: selectedIndex, onChanged: (value) => setState(() => selectedIndex = value)),
            const SizedBox(height: 14),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: switch (selectedIndex) {
                  0 => const StatScreen(),
                  1 => const InventoryScreen(),
                  2 => const DataScreen(),
                  3 => const MapScreen(),
                  _ => const RadioScreen(),
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('HP 082/100', style: PipText.small(context)),
                Text('WG 074/220', style: PipText.small(context)),
                Text('CAPS 001247', style: PipText.small(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.tabs, required this.selectedIndex, required this.onChanged});

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (index) {
        final active = index == selectedIndex;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: InkWell(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? PipColors.glowGreen.withOpacity(.16) : Colors.transparent,
                  border: Border.all(color: active ? PipColors.phosphor : PipColors.glowGreen.withOpacity(.65)),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: PipText.body(context).copyWith(
                    color: active ? PipColors.phosphor : PipColors.glowGreen.withOpacity(.78),
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
