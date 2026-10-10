import 'package:flutter_test/flutter_test.dart';
import 'package:pipboyapp/core/pip_data.dart';
import 'package:pipboyapp/models/pip_models.dart';
import 'package:pipboyapp/state/pipboy_state.dart';

void main() {
  group('PipBoyState', () {
    late PipBoyState state;
    setUp(() => state = PipBoyState());
    tearDown(() => state.dispose());

    PipInventoryItem item(String id) =>
        state.inventory.firstWhere((item) => item.id == id);

    test('should preserve inventory and attributes through read-only views',
        () {
      expect(() => state.inventory.clear(), throwsUnsupportedError);
      expect(() => state.special['STR'] = 99, throwsUnsupportedError);
      expect(() => state.visibleInventory.clear(), throwsUnsupportedError);
    });

    test('should spend limited attribute points and increase carry capacity',
        () {
      state.increaseSpecial('unknown');
      expect(state.attributePoints, 3);
      for (var i = 0; i < 5; i++) {
        state.increaseSpecial('STR');
      }
      expect(state.special['STR'], 9);
      expect(state.attributePoints, 0);
      expect(state.carryCapacity, 250);
    });

    test('should replace equipment only in the corresponding slot', () {
      state.toggleEquipment('laser');
      state.toggleEquipment('armor');
      state.toggleEquipment('rifle');
      expect(state.isEquipped(item('laser')), isFalse);
      expect(state.isEquipped(item('rifle')), isTrue);
      expect(state.damage, 42);
      expect(state.defense, 35);
      state.toggleEquipment('rifle');
      expect(state.damage, 0);
      expect(state.defense, 35);
      state.toggleEquipment('stimpak');
      expect(state.defense, 35);
    });

    test('should remove dropped equipment and count stack weight', () {
      final before = state.carryWeight;
      state.dropItem('scrap');
      expect(state.carryWeight, closeTo(before - 4, .00001));
      expect(item('scrap').quantity, 11);
      state.toggleEquipment('laser');
      state.dropItem('laser');
      expect(state.damage, 0);
      expect(state.inventory.any((item) => item.id == 'laser'), isFalse);
      state.dropItem('laser');
    });

    test('should detect overencumbrance and clear it after dropping weight',
        () {
      final heavy = PipBoyState(initialInventory: const [
        PipInventoryItem(
            id: 'load',
            name: 'Heavy scrap',
            type: ItemType.misc,
            value: 1,
            weight: 110,
            quantity: 3),
      ]);
      addTearDown(heavy.dispose);
      expect(heavy.overencumbered, isTrue);
      expect(heavy.condition, 'OVERENCUMBERED');
      heavy.dropItem('load');
      expect(heavy.carryWeight, 220);
      expect(heavy.overencumbered, isFalse);
    });

    test(
        'should prevent wasting aid and clamp healing to radiation-limited health',
        () {
      expect(state.maxHp, 82);
      state.useItem('stimpak');
      expect(item('stimpak').quantity, 3);
      state.useItem('radaway');
      expect(state.rads, 0);
      expect(state.maxHp, 100);
      expect(item('radaway').quantity, 1);
      state.useItem('stimpak');
      expect(state.hp, 100);
      expect(item('stimpak').quantity, 2);
      expect(state.condition, 'HEALTHY');
      state.useItem('radaway');
      state.useItem('stimpak');
      expect(item('radaway').quantity, 1);
      expect(item('stimpak').quantity, 2);
    });

    test('should restore AP and remove exhausted stacks', () {
      state.useItem('cola');
      expect(state.ap, 84);
      state.useItem('cola');
      expect(state.ap, 100);
      expect(state.inventory.any((item) => item.id == 'cola'), isFalse);
      state.useItem('cola');
      expect(state.ap, 100);
    });

    test('should filter inventory without altering its contents', () {
      state.setFilter(ItemType.weapon);
      expect(state.visibleInventory.length, 2);
      expect(
          state.visibleInventory.every((item) => item.type == ItemType.weapon),
          isTrue);
      state.setFilter(null);
      expect(state.visibleInventory.length, state.inventory.length);
    });

    test('should grant quest reward exactly once and clear tracked destination',
        () {
      final quest = quests.first;
      final caps = state.caps;
      expect(state.waypointId, quest.locationId);
      state.completeObjective(quest.id, -1);
      state.completeObjective(quest.id, 99);
      state.completeObjective('unknown', 0);
      expect(state.completedCount(quest), 0);
      for (var i = 0; i < quest.objectives.length; i++) {
        state.completeObjective(quest.id, i);
      }
      expect(state.questDone(quest), isTrue);
      expect(state.caps, caps + quest.reward);
      expect(state.trackedQuestId, isNull);
      expect(state.waypointId, isNull);
      state.completeObjective(quest.id, 0);
      state.trackQuest(quest.id);
      expect(state.caps, caps + quest.reward);
      expect(state.trackedQuestId, isNull);
    });

    test('should switch tracked quests and map destinations together', () {
      state.trackQuest('water');
      expect(state.trackedQuestId, 'water');
      expect(state.waypointId, 'purifier');
      state.trackQuest('water');
      expect(state.trackedQuestId, isNull);
      expect(state.waypointId, isNull);
      state.trackQuest('unknown');
      expect(state.trackedQuestId, isNull);
    });

    test(
        'should require discovery for manual waypoints and reject unknown locations',
        () {
      state.selectLocation('bunker');
      state.toggleWaypoint();
      expect(state.waypointId, 'relay');
      state.discoverSelectedLocation();
      expect(state.isDiscovered('bunker'), isTrue);
      state.toggleWaypoint();
      expect(state.waypointId, 'bunker');
      state.toggleWaypoint();
      expect(state.waypointId, isNull);
      state.selectLocation('unknown');
      expect(state.selectedLocationId, 'bunker');
    });

    test('should retain station and volume while switching receiver power', () {
      expect(state.transmission, 'RECEIVER OFF');
      state.selectStation('beacon');
      state.toggleRadio();
      expect(state.transmission, contains('Relay Tower Beta'));
      expect(state.station.signal, .91);
      state.setVolume(2);
      expect(state.volume, 1);
      state.setVolume(-1);
      expect(state.volume, 0);
      state.setVolume(double.nan);
      expect(state.volume, 0);
      state.selectStation('unknown');
      expect(state.station.id, 'beacon');
      state.toggleRadio();
      expect(state.transmission, 'RECEIVER OFF');
      expect(state.station.id, 'beacon');
    });

    test(
        'should notify listeners once per successful item command and ignore no-ops',
        () {
      var notifications = 0;
      state.addListener(() => notifications++);
      state.useItem('unknown');
      state.toggleEquipment('unknown');
      state.dropItem('unknown');
      state.useItem('stimpak');
      expect(notifications, 0);
      state.useItem('radaway');
      expect(notifications, 1);
      state.toggleEquipment('laser');
      expect(notifications, 2);
    });
  });
}
