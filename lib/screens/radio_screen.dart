import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../state/pipboy_state.dart';
import '../widgets/terminal_bar.dart';
import '../widgets/terminal_panel.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key, required this.state});
  final PipBoyState state;

  @override
  Widget build(BuildContext context) => TerminalPanel(
        title: 'RADIO // SIGNALS',
        child: ListView(children: [
          SwitchListTile(
            key: const ValueKey('radio-power'),
            contentPadding: EdgeInsets.zero,
            title: Text('RECEIVER ${state.radioEnabled ? 'ON' : 'OFF'}',
                style: PipText.body(context)),
            value: state.radioEnabled,
            onChanged: (_) => state.toggleRadio(),
          ),
          for (final station in stations)
            ListTile(
              key: ValueKey('station-${station.id}'),
              contentPadding: EdgeInsets.zero,
              selected: state.station.id == station.id,
              leading: Icon(
                  state.station.id == station.id
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: PipColors.glowGreen),
              title: Text(station.name, style: PipText.body(context)),
              subtitle: Text(station.frequency, style: PipText.small(context)),
              onTap: () => state.selectStation(station.id),
            ),
          const SizedBox(height: 16),
          TerminalBar(
              label: 'SIG',
              value: state.radioEnabled ? state.station.signal : 0),
          TerminalBar(
              label: 'NOISE',
              value: state.radioEnabled ? 1 - state.station.signal : 0,
              warning: true),
          Text('VOLUME ${(state.volume * 100).round()}%',
              style: PipText.body(context)),
          Slider(
              key: const ValueKey('radio-volume'),
              value: state.volume,
              onChanged: state.radioEnabled ? state.setVolume : null,
              semanticFormatterCallback: (value) =>
                  '${(value * 100).round()} percent'),
          Text('TRANSMISSION: ${state.transmission}',
              style: PipText.body(context)),
          const SizedBox(height: 12),
          Text(
              'TEXT RECEIVER SIMULATION // No audio stream or game recordings included.',
              style: PipText.small(context)),
        ]),
      );
}
