import '../models/pip_models.dart';

const inventoryItems = <PipInventoryItem>[
  PipInventoryItem(
      id: 'laser',
      name: 'Aged Laser Sidearm',
      type: ItemType.weapon,
      value: 125,
      weight: 3.2,
      power: 24),
  PipInventoryItem(
      id: 'rifle',
      name: 'Wasteland Hunting Rifle',
      type: ItemType.weapon,
      value: 160,
      weight: 8,
      power: 42),
  PipInventoryItem(
      id: 'stimpak',
      name: 'Field Stimpak',
      type: ItemType.aid,
      value: 45,
      weight: .1,
      quantity: 3,
      power: 30,
      effect: AidEffect.heal),
  PipInventoryItem(
      id: 'radaway',
      name: 'Rad Scrubber Vial',
      type: ItemType.aid,
      value: 80,
      weight: .4,
      quantity: 2,
      power: 20,
      effect: AidEffect.removeRads),
  PipInventoryItem(
      id: 'suit',
      name: 'Vault-Tec Style Jumpsuit',
      type: ItemType.apparel,
      value: 65,
      weight: 2,
      power: 5),
  PipInventoryItem(
      id: 'armor',
      name: 'Salvaged Combat Armor',
      type: ItemType.apparel,
      value: 220,
      weight: 18,
      power: 35),
  PipInventoryItem(
      id: 'cola',
      name: 'Pre-War Cola',
      type: ItemType.aid,
      value: 12,
      weight: .8,
      quantity: 2,
      power: 20,
      effect: AidEffect.refresh),
  PipInventoryItem(
      id: 'scrap',
      name: 'Purifier Scrap',
      type: ItemType.misc,
      value: 12,
      weight: 4,
      quantity: 12),
  PipInventoryItem(
      id: 'cells',
      name: 'Fusion Cell',
      type: ItemType.ammo,
      value: 3,
      weight: 0,
      quantity: 48),
];

const quests = <PipQuest>[
  PipQuest(
      id: 'signal',
      title: 'Signal In The Static',
      locationId: 'relay',
      objectives: [
        'Locate the relay tower.',
        'Decode the emergency broadcast.',
        'Report the signal to the settlement.'
      ],
      reward: 150),
  PipQuest(
      id: 'water',
      title: 'Clean Water Run',
      locationId: 'purifier',
      objectives: [
        'Find a functioning purifier module.',
        'Return the module to the settlement.'
      ],
      reward: 120),
  PipQuest(
      id: 'tape',
      title: 'Old World Bluescreen',
      locationId: 'bunker',
      objectives: [
        'Enter the abandoned bunker.',
        'Recover the diagnostic holotape.'
      ],
      reward: 200),
];

const locations = <PipLocation>[
  PipLocation(
      id: 'vault',
      name: 'Vault Exit',
      grid: '7B',
      x: .15,
      y: .8,
      discovered: true),
  PipLocation(
      id: 'settlement',
      name: 'Dustfall Settlement',
      grid: '6C',
      x: .42,
      y: .58,
      discovered: true),
  PipLocation(
      id: 'relay', name: 'Relay Tower Beta', grid: '4D', x: .62, y: .35),
  PipLocation(
      id: 'purifier', name: 'Water Treatment Plant', grid: '3E', x: .82, y: .2),
  PipLocation(id: 'bunker', name: 'Abandoned Bunker', grid: '5B', x: .2, y: .4),
];

const stations = <PipStation>[
  PipStation(
      id: 'classics',
      name: 'WASTELAND CLASSICS',
      frequency: '99.7 FM',
      signal: .72,
      broadcast: 'Old world transmission fragment'),
  PipStation(
      id: 'beacon',
      name: 'EMERGENCY BEACON',
      frequency: '104.2 FM',
      signal: .91,
      broadcast: 'Survivors: proceed to Relay Tower Beta.'),
  PipStation(
      id: 'relay',
      name: 'RELAY TOWER BETA',
      frequency: '108.1 FM',
      signal: .48,
      broadcast: 'Repeating settlement supply bulletin.'),
];

const specialStats = <String, int>{
  'STR': 6,
  'PER': 7,
  'END': 5,
  'CHA': 4,
  'INT': 8,
  'AGI': 6,
  'LCK': 3
};
const specialDescriptions = <String, String>{
  'STR': 'STRENGTH // Carry capacity and melee power',
  'PER': 'PERCEPTION // Awareness and targeting',
  'END': 'ENDURANCE // Health and resilience',
  'CHA': 'CHARISMA // Barter and persuasion',
  'INT': 'INTELLIGENCE // Learning and technology',
  'AGI': 'AGILITY // Action points and stealth',
  'LCK': 'LUCK // Critical hits and fortune',
};
