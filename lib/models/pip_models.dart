class PipInventoryItem {
  const PipInventoryItem({required this.name, required this.type, required this.value, required this.weight});

  final String name;
  final String type;
  final int value;
  final double weight;
}

class PipQuest {
  const PipQuest({required this.title, required this.objective, required this.active});

  final String title;
  final String objective;
  final bool active;
}
