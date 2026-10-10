import 'package:flutter/foundation.dart';

import '../core/pip_data.dart';
import '../models/pip_models.dart';

/// In-memory session shared by all five terminal screens.
/// Widgets only render this model and forward commands to it.
class PipBoyState extends ChangeNotifier {
  final List<PipInventoryItem> _inventory = List.of(inventoryItems);
  final Map<String, int> _special = Map.of(specialStats);
  final Map<String, Set<int>> _completed = {};
  final Set<String> _rewarded = {};
  final Set<String> _discovered = {
    for (final location in locations)
      if (location.discovered) location.id,
  };
  final Map<ItemType, String> _equipment = {};
  int _hp = 82;
  int _ap = 64;
  int _rads = 18;
  int _caps = 1247;
  int _attributePoints = 3;
  String? _trackedQuestId = 'signal';
  String? _waypointId = 'relay';
  String _selectedLocationId = 'vault';
  String _stationId = 'classics';
  bool _radioEnabled = false;
  double _volume = .5;
  ItemType? _filter;

  List<PipInventoryItem> get inventory => List.unmodifiable(_inventory);
  List<PipInventoryItem> get visibleInventory => List.unmodifiable(
      _inventory.where((item) => _filter == null || item.type == _filter));
  Map<String, int> get special => Map.unmodifiable(_special);
  int get hp => _hp;
  int get ap => _ap;
  int get rads => _rads;
  int get maxHp => 100 - _rads;
  int get caps => _caps;
  int get attributePoints => _attributePoints;
  int get carryCapacity => 160 + _special['STR']! * 10;
  double get carryWeight =>
      _inventory.fold(0, (sum, item) => sum + item.weight * item.quantity);
  bool get overencumbered => carryWeight > carryCapacity;
  int get damage => _equippedPower(ItemType.weapon);
  int get defense => _equippedPower(ItemType.apparel);
  String get condition => overencumbered
      ? 'OVERENCUMBERED'
      : (_rads > 0 ? 'IRRADIATED' : 'HEALTHY');
  ItemType? get filter => _filter;
  String? get trackedQuestId => _trackedQuestId;
  String? get waypointId => _waypointId;
  String get selectedLocationId => _selectedLocationId;
  PipLocation get selectedLocation =>
      locations.firstWhere((l) => l.id == _selectedLocationId);
  PipStation get station => stations.firstWhere((s) => s.id == _stationId);
  bool get radioEnabled => _radioEnabled;
  double get volume => _volume;
  String get transmission => _radioEnabled ? station.broadcast : 'RECEIVER OFF';

  int _equippedPower(ItemType type) {
    for (final item in _inventory) {
      if (_equipment[type] == item.id) return item.power;
    }
    return 0;
  }

  bool isEquipped(PipInventoryItem item) => _equipment[item.type] == item.id;
  bool isDiscovered(String id) => _discovered.contains(id);
  bool objectiveDone(String questId, int index) =>
      _completed[questId]?.contains(index) ?? false;
  int completedCount(PipQuest quest) => _completed[quest.id]?.length ?? 0;
  bool questDone(PipQuest quest) =>
      completedCount(quest) == quest.objectives.length;
  bool canUse(PipInventoryItem item) =>
      item.quantity > 0 &&
      switch (item.effect) {
        AidEffect.heal => _hp < maxHp,
        AidEffect.removeRads => _rads > 0,
        AidEffect.refresh => _ap < 100,
        null => false,
      };

  void setFilter(ItemType? filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }

  void increaseSpecial(String key) {
    if (!_special.containsKey(key) ||
        _attributePoints == 0 ||
        _special[key]! >= 10) return;
    _special[key] = _special[key]! + 1;
    _attributePoints--;
    notifyListeners();
  }

  void toggleEquipment(String id) {
    final index = _inventory.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final item = _inventory[index];
    if (!item.equippable) return;
    if (isEquipped(item)) {
      _equipment.remove(item.type);
    } else {
      _equipment[item.type] = id;
    }
    notifyListeners();
  }

  void useItem(String id) {
    final index = _inventory.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final item = _inventory[index];
    if (!canUse(item)) return;
    switch (item.effect) {
      case AidEffect.heal:
        _hp = (_hp + item.power).clamp(0, maxHp);
      case AidEffect.removeRads:
        _rads = (_rads - item.power).clamp(0, 100);
      case AidEffect.refresh:
        _ap = (_ap + item.power).clamp(0, 100);
      case null:
        return;
    }
    if (item.quantity == 1) {
      _inventory.removeAt(index);
    } else {
      _inventory[index] = item.withQuantity(item.quantity - 1);
    }
    notifyListeners();
  }

  void dropItem(String id) {
    final index = _inventory.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final item = _inventory[index];
    if (item.quantity == 1) {
      _inventory.removeAt(index);
      if (isEquipped(item)) _equipment.remove(item.type);
    } else {
      _inventory[index] = item.withQuantity(item.quantity - 1);
    }
    notifyListeners();
  }

  void trackQuest(String id) {
    final matches = quests.where((quest) => quest.id == id);
    if (matches.isEmpty || questDone(matches.first)) return;
    _trackedQuestId = _trackedQuestId == id ? null : id;
    _waypointId = _trackedQuestId == null ? null : matches.first.locationId;
    notifyListeners();
  }

  void completeObjective(String id, int index) {
    final matches = quests.where((quest) => quest.id == id);
    if (matches.isEmpty) return;
    final quest = matches.first;
    if (index < 0 ||
        index >= quest.objectives.length ||
        objectiveDone(id, index)) return;
    (_completed[id] ??= {}).add(index);
    if (questDone(quest) && _rewarded.add(id)) {
      _caps += quest.reward;
      if (_trackedQuestId == id) {
        _trackedQuestId = null;
        _waypointId = null;
      }
    }
    notifyListeners();
  }

  void selectLocation(String id) {
    if (!locations.any((location) => location.id == id)) return;
    _selectedLocationId = id;
    notifyListeners();
  }

  void discoverSelectedLocation() {
    if (_discovered.add(_selectedLocationId)) notifyListeners();
  }

  void toggleWaypoint() {
    if (!isDiscovered(_selectedLocationId)) return;
    _waypointId =
        _waypointId == _selectedLocationId ? null : _selectedLocationId;
    notifyListeners();
  }

  void selectStation(String id) {
    if (!stations.any((station) => station.id == id) || _stationId == id)
      return;
    _stationId = id;
    notifyListeners();
  }

  void toggleRadio() {
    _radioEnabled = !_radioEnabled;
    notifyListeners();
  }

  void setVolume(double value) {
    if (!value.isFinite) return;
    final clamped = value.clamp(0.0, 1.0);
    if (_volume == clamped) return;
    _volume = clamped;
    notifyListeners();
  }
}
