enum ItemType { weapon, apparel, aid, misc, ammo }

enum AidEffect { heal, removeRads, refresh }

class PipInventoryItem {
  const PipInventoryItem(
      {required this.id,
      required this.name,
      required this.type,
      required this.value,
      required this.weight,
      this.quantity = 1,
      this.power = 0,
      this.effect});
  final String id;
  final String name;
  final ItemType type;
  final int value;
  final double weight;
  final int quantity;
  final int power;
  final AidEffect? effect;
  bool get equippable => type == ItemType.weapon || type == ItemType.apparel;
  PipInventoryItem withQuantity(int quantity) => PipInventoryItem(
      id: id,
      name: name,
      type: type,
      value: value,
      weight: weight,
      quantity: quantity,
      power: power,
      effect: effect);
}

class PipQuest {
  const PipQuest(
      {required this.id,
      required this.title,
      required this.objectives,
      required this.locationId,
      this.reward = 100});
  final String id;
  final String title;
  final List<String> objectives;
  final String locationId;
  final int reward;
}

class PipLocation {
  const PipLocation(
      {required this.id,
      required this.name,
      required this.grid,
      required this.x,
      required this.y,
      this.discovered = false});
  final String id;
  final String name;
  final String grid;
  final double x;
  final double y;
  final bool discovered;
}

class PipStation {
  const PipStation(
      {required this.id,
      required this.name,
      required this.frequency,
      required this.signal,
      required this.broadcast});
  final String id;
  final String name;
  final String frequency;
  final double signal;
  final String broadcast;
}
