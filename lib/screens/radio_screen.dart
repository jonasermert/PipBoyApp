import 'package:flutter/material.dart';

import '../core/pip_theme.dart';
import '../widgets/terminal_bar.dart';
import '../widgets/terminal_panel.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const stations = ['WASTELAND CLASSICS 99.7', 'EMERGENCY BEACON 104.2', 'RELAY TOWER BETA', 'STATIC CHANNEL --.-'];
    return TerminalPanel(
      title: 'RADIO // SIGNALS',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...stations.map((station) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text('> $station FM', style: PipText.body(context)),
              )),
          const Spacer(),
          const TerminalBar(label: 'SIG', value: .72),
          const TerminalBar(label: 'NOISE', value: .43, warning: true),
          Text('NOW PLAYING: OLD WORLD TRANSMISSION FRAGMENT', style: PipText.small(context)),
        ],
      ),
    );
  }
}
