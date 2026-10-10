# PipBoy App

An interactive Flutter terminal inspired by the Fallout Pip-Boy. The five existing STAT, INV, DATA, MAP and RADIO tabs retain their original green phosphor typography, CRT scanlines, noise, vignette, silhouette and custom-painted grid. All artwork is drawn in Flutter; no official game images, logos, music or recordings are bundled.

## Interactive terminal

STAT shows health, action points, radiation, equipment damage and armor resistance. Radiation reduces maximum health: the initial 18 RAD limits HP to 82. Three available S.P.E.C.I.A.L. points can be spent on attributes up to 10. Strength determines carry capacity using `160 + STR * 10`.

INV supports category filters, item stacks, per-unit weight and value, weapons and apparel equipment slots, aid consumption and dropping one item at a time. Equipping another weapon replaces the previous weapon without changing armor. Dropping an equipped item clears its slot. Field Stimpaks restore up to 30 HP, Rad Scrubber Vials remove up to 20 RAD and Pre-War Cola restores up to 20 AP. Aid is disabled when it would have no effect. To try healing from the initial state, use a Rad Scrubber first, then a Stimpak. The footer updates HP, carried weight and caps across tabs. Overencumbrance is shown when weight exceeds capacity; the default load is below this limit.

DATA provides three quests with individually completable objectives, progress, tracking and cap rewards. Objectives are completed manually in this simulation. Completing the final objective pays the reward once and clears the tracked quest and destination. Completed objectives cannot be undone and completed quests cannot be tracked again.

MAP offers five fictional locations with selectable markers and a scrollable directory. Select an undiscovered location and choose DISCOVER LOCATION, then SET WAYPOINT. Quest tracking can mark an undiscovered destination. Amber flags indicate the current waypoint. A manual waypoint replaces the visible destination while the quest remains tracked; toggling quest tracking updates the destination again. The player position remains at Vault Exit. There is no GPS, travel simulation or external map service.

RADIO is a text receiver simulation with three selectable stations, power control, station-specific signal and noise bars, remembered volume and transmission text. Volume is a simulated setting only: no audio is played and no network stream is opened.

## Run and validate

Flutter 3.27 or newer and Dart 3.6 or newer are required. The checked-in dependency lockfile and validation workflow use Flutter 3.47.5 / Dart 3.13.4.

```sh
flutter pub get
flutter run
flutter analyze
flutter test
flutter build web
```

## Architecture

The existing `core/`, `models/`, `painters/`, `screens/` and `widgets/` layout is retained. `lib/state/pipboy_state.dart` owns the shared session using Flutter's built-in ChangeNotifier. `PipBoyHome` creates and disposes it, listens with ListenableBuilder and passes it to the screens. Widgets render state and forward commands; inventory, character, quest, map and radio rules live in the model. No additional state-management dependency is needed. Model objects are immutable and exposed inventory and attribute collections are read-only snapshots. An initial inventory can be injected for alternative sessions and boundary tests.

```dart
final session = PipBoyState();
session.useItem('radaway');
session.useItem('stimpak');
session.toggleEquipment('laser');
session.trackQuest('water');
// HP 100/100, DMG 24, waypoint at the purifier.
session.dispose();
```

Session changes survive tab switches but reset on application restart. Storage, combat, experience progression, item acquisition, audio playback and location services are outside the current implementation. Sample data is defined in `lib/core/pip_data.dart`. Architecture decisions, interaction checks and test coverage are described in [development notes](docs/DEVELOPMENT.md).

## Screenshots

The repository's existing screenshots show the original static design. The interactive implementation preserves that visual language while adding controls and live state.

![Original STAT terminal](screenshots/Screenshot_1783252270.png)
![Original map terminal](screenshots/Screenshot_1783252287.png)

## License

For personal and educational use. No official Fallout assets are included or required.
