import 'package:flutter/material.dart';

import '../core/pip_data.dart';
import '../core/pip_theme.dart';
import '../state/pipboy_state.dart';
import '../widgets/terminal_panel.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key, required this.state});
  final PipBoyState state;

  @override
  Widget build(BuildContext context) => TerminalPanel(
        title: 'DATA // QUESTS',
        child: ListView.separated(
          itemCount: quests.length,
          separatorBuilder: (_, __) => const Divider(color: PipColors.dimGreen),
          itemBuilder: (context, index) {
            final quest = quests[index];
            final done = state.questDone(quest);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${done ? '[COMPLETE]' : state.trackedQuestId == quest.id ? '[TRACKED]' : '[LOG]'} ${quest.title}',
                      style: PipText.body(context)),
                  Text(
                      '${state.completedCount(quest)}/${quest.objectives.length} OBJECTIVES // REWARD ${quest.reward} CAPS',
                      style: PipText.small(context)),
                  LinearProgressIndicator(
                      value: state.completedCount(quest) /
                          quest.objectives.length),
                  for (var i = 0; i < quest.objectives.length; i++)
                    CheckboxListTile(
                      key: ValueKey('objective-${quest.id}-$i'),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(quest.objectives[i],
                          style: PipText.small(context)),
                      value: state.objectiveDone(quest.id, i),
                      onChanged: state.objectiveDone(quest.id, i)
                          ? null
                          : (_) => state.completeObjective(quest.id, i),
                    ),
                  TextButton(
                      key: ValueKey('track-${quest.id}'),
                      onPressed: done ? null : () => state.trackQuest(quest.id),
                      child: Text(state.trackedQuestId == quest.id
                          ? 'STOP TRACKING'
                          : 'TRACK ON MAP')),
                ]);
          },
        ),
      );
}
