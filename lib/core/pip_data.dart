import '../models/pip_models.dart';

const inventoryItems = <PipInventoryItem>[
  PipInventoryItem(name: 'Aged Laser Sidearm', type: 'WEAPON', value: 125, weight: 3.2),
  PipInventoryItem(name: 'Field Stimpak', type: 'AID', value: 45, weight: .1),
  PipInventoryItem(name: 'Rad Scrubber Vial', type: 'AID', value: 80, weight: .4),
  PipInventoryItem(name: 'Vault-Tec Style Jumpsuit', type: 'APPAREL', value: 65, weight: 2.0),
  PipInventoryItem(name: 'Pre-War Cola', type: 'MISC', value: 12, weight: .8),
  PipInventoryItem(name: 'Fusion Cell', type: 'AMMO', value: 3, weight: 0),
];

const quests = <PipQuest>[
  PipQuest(title: 'Signal In The Static', objective: 'Follow the emergency broadcast north of the relay tower.', active: true),
  PipQuest(title: 'Clean Water Run', objective: 'Find a functioning purifier module.', active: true),
  PipQuest(title: 'Old World Bluescreen', objective: 'Recover diagnostic holotape from the bunker terminal.', active: false),
];

const specialStats = <String, int>{
  'STR': 6,
  'PER': 7,
  'END': 5,
  'CHA': 4,
  'INT': 8,
  'AGI': 6,
  'LCK': 3,
};
