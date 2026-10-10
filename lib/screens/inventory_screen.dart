import 'package:flutter/material.dart';

import '../core/pip_theme.dart';
import '../models/pip_models.dart';
import '../state/pipboy_state.dart';
import '../widgets/terminal_panel.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key, required this.state});
  final PipBoyState state;

  @override
  Widget build(BuildContext context) => TerminalPanel(
        title: 'INVENTORY // ITEMS',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              'WG ${state.carryWeight.toStringAsFixed(1)}/${state.carryCapacity} // ${state.overencumbered ? 'OVERENCUMBERED' : 'CAPACITY OK'}',
              style: PipText.body(context)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _filter(context, null, 'ALL'),
              for (final type in ItemType.values)
                _filter(context, type, type.name.toUpperCase()),
            ]),
          ),
          const SizedBox(height: 8),
          Expanded(
              child: state.visibleInventory.isEmpty
                  ? Center(
                      child: Text('NO ITEMS IN THIS CATEGORY',
                          style: PipText.body(context)))
                  : ListView.separated(
                      itemCount: state.visibleInventory.length,
                      separatorBuilder: (_, __) =>
                          const Divider(color: PipColors.dimGreen),
                      itemBuilder: (context, index) {
                        final item = state.visibleInventory[index];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${state.isEquipped(item) ? '[E]' : '>'} ${item.name} x${item.quantity}',
                                  style: PipText.body(context)),
                              Text(
                                  '${item.type.name.toUpperCase()} // VAL ${item.value} // WG ${item.weight.toStringAsFixed(1)} EACH',
                                  style: PipText.small(context)),
                              if (item.power > 0)
                                Text(
                                    '${item.type == ItemType.weapon ? 'DMG' : item.type == ItemType.apparel ? 'DR' : item.effect == AidEffect.heal ? 'HP +' : item.effect == AidEffect.removeRads ? 'RAD -' : 'AP +'} ${item.power}',
                                    style: PipText.small(context)),
                              Wrap(spacing: 8, children: [
                                if (item.equippable)
                                  TextButton(
                                      key: ValueKey('equip-${item.id}'),
                                      onPressed: () =>
                                          state.toggleEquipment(item.id),
                                      child: Text(state.isEquipped(item)
                                          ? 'UNEQUIP'
                                          : 'EQUIP')),
                                if (item.effect != null)
                                  TextButton(
                                      key: ValueKey('use-${item.id}'),
                                      onPressed: state.canUse(item)
                                          ? () => state.useItem(item.id)
                                          : null,
                                      child: const Text('USE')),
                                TextButton(
                                    key: ValueKey('drop-${item.id}'),
                                    onPressed: () => state.dropItem(item.id),
                                    child: const Text('DROP ONE')),
                              ]),
                            ]);
                      },
                    )),
        ]),
      );

  Widget _filter(BuildContext context, ItemType? type, String label) => Padding(
        padding: const EdgeInsets.only(right: 6),
        child: ChoiceChip(
            label: Text(label),
            selected: state.filter == type,
            onSelected: (_) => state.setFilter(type)),
      );
}
