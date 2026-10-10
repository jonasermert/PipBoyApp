import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../painters/terminal_painters.dart';
import '../state/pipboy_state.dart';
import '../widgets/terminal_panel.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.state});
  final PipBoyState state;

  @override
  Widget build(BuildContext context) => TerminalPanel(
        title: 'MAP // WASTELAND',
        child: ListView(children: [
          SizedBox(
              height: 240,
              child: LayoutBuilder(
                  builder: (context, constraints) => Stack(children: [
                        Positioned.fill(
                            child: CustomPaint(painter: WastelandMapPainter())),
                        for (final location in locations)
                          Positioned(
                            left: (constraints.maxWidth - 48) * location.x,
                            top: (constraints.maxHeight - 48) * location.y,
                            child: IconButton(
                              key: ValueKey('marker-${location.id}'),
                              tooltip:
                                  '${location.name} // ${state.isDiscovered(location.id) ? 'DISCOVERED' : 'UNKNOWN'}',
                              color: state.waypointId == location.id
                                  ? PipColors.amber
                                  : PipColors.glowGreen,
                              onPressed: () =>
                                  state.selectLocation(location.id),
                              icon: Icon(state.waypointId == location.id
                                  ? Icons.flag
                                  : state.isDiscovered(location.id)
                                      ? Icons.location_on
                                      : Icons.help_outline),
                            ),
                          ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('▲ CURRENT POSITION // VAULT EXIT 7B',
                                style: PipText.small(context))),
                      ]))),
          const SizedBox(height: 12),
          Text('LOCATION DIRECTORY', style: PipText.body(context)),
          for (final location in locations)
            ListTile(
              key: ValueKey('location-${location.id}'),
              contentPadding: EdgeInsets.zero,
              selected: state.selectedLocationId == location.id,
              leading: Icon(
                  state.waypointId == location.id ? Icons.flag : Icons.place,
                  color: PipColors.glowGreen),
              title: Text(location.name, style: PipText.body(context)),
              subtitle: Text(
                  'GRID ${location.grid} // ${state.isDiscovered(location.id) ? 'DISCOVERED' : 'UNDISCOVERED'}',
                  style: PipText.small(context)),
              onTap: () => state.selectLocation(location.id),
            ),
          Text('SELECTED: ${state.selectedLocation.name}',
              style: PipText.body(context)),
          Wrap(spacing: 8, children: [
            TextButton(
                key: const ValueKey('discover-location'),
                onPressed: state.isDiscovered(state.selectedLocationId)
                    ? null
                    : state.discoverSelectedLocation,
                child: const Text('DISCOVER LOCATION')),
            TextButton(
                key: const ValueKey('toggle-waypoint'),
                onPressed: state.isDiscovered(state.selectedLocationId)
                    ? state.toggleWaypoint
                    : null,
                child: Text(state.waypointId == state.selectedLocationId
                    ? 'CLEAR WAYPOINT'
                    : 'SET WAYPOINT')),
          ]),
          Text(
              'Simulation map // select a marker or directory entry. Quest tracking sets a destination even before discovery.',
              style: PipText.small(context)),
        ]),
      );
}
