# Development and verification

## Session boundaries

PipBoyState is a synchronous, in-memory view model shared by the five tabs. There is no asynchronous loading state because no external data source is involved. Keeping Flutter foundation as its only framework dependency makes business rules testable without widgets or BuildContext. Screens retain the repository's existing organization instead of undergoing an unrelated architecture migration. A future persistence service can load and save a session through this boundary without moving business rules into widgets.

Each supported command validates IDs and bounds before mutation. Aid updates an immutable inventory entry or removes an exhausted stack. No-effect aid commands leave both character and inventory unchanged. Equipment has one weapon slot and one apparel slot. Carried weight includes equipped gear and every unit in a stack; ammunition currently has zero weight. Weight above capacity reports OVERENCUMBERED, while equality remains valid. There is no movement system to slow down, and no item acquisition system in this iteration.

Radiation is modeled as an integer percentage, so maximum health is `100 - RAD`. Removing radiation increases the health ceiling without healing automatically. Healing cannot exceed that ceiling. AP is capped at 100. Attribute points are limited to the three starting points, and each attribute is capped at 10. Damage and resistance come from equipped items; combat is not simulated.

Quest objectives are one-way completion actions. A set stores completed objective indexes, and a separate reward guard prevents duplicate payouts. Each quest references a location ID. Tracking changes the visible waypoint; finishing the tracked quest clears it. Manual map discovery is independent of quest completion. Directory entries and markers select the same location. Discovery does not move the player.

Radio commands retain the selected station and volume while switching power. Signal and noise are zero when powered off. Volume is clamped to 0–1 and non-finite values are ignored. This is explicitly a text-only receiver and contains no misleading playback claim.

## Automated coverage

The 13 state tests exercise immutable collection access, limited attribute spending, equipment replacement and unequipping, dropped equipment, stack weight, the exact carry-capacity boundary, no-effect aid, health/radiation/AP limits, stack exhaustion, filtering, quest reward idempotency, invalid objective indexes and IDs, tracked destinations, discovery requirements, receiver settings and notifications.

The five widget tests exercise cross-tab inventory and equipment state, health changes in the live footer, quest objective progress and map tracking, map discovery and manual waypoints, station/power retention and disabled/enabled volume controls. Every tab is checked for layout exceptions on 320×568 portrait and 844×390 landscape surfaces at 140% text scaling. Tests use a built-in font to avoid external font downloads. Google Fonts remains part of the production theme.

```sh
flutter analyze
flutter test
```

The GitHub Actions workflow runs dependency resolution, analysis, all tests and a release web build on Flutter 3.47.5. The web build confirms compilation; it does not replace native device testing. iOS, Android and desktop deployment have not been validated by this change.

## Manual walkthrough

Open INV, equip Aged Laser Sidearm and Salvaged Combat Armor, then inspect DMG 24 and DR 35 in STAT. In INV use a Rad Scrubber Vial and then a Field Stimpak; the footer should reach HP 100/100. Reusing either at full health and zero radiation should be disabled. Drop an equipped weapon and confirm DMG returns to zero. Change inventory categories and return to ALL.

In DATA complete one Signal In The Static objective and confirm 1/3 progress. Track Clean Water Run and open MAP: Water Treatment Plant should show an amber flag. Select Abandoned Bunker, discover it and set a manual waypoint. Return to DATA and confirm progress remains. Complete all three Signal objectives and verify that caps increase by exactly 150 once.

In RADIO select EMERGENCY BEACON, switch the receiver on and adjust volume. Confirm its broadcast and signal bars, switch tabs and return to check settings. Power off to see RECEIVER OFF and disabled volume. No sound should be expected.

## Visual compatibility

Controls use the terminal's green ColorScheme. Material surfaces are placed inside the decorated terminal panel so selection and ink feedback remain visible. The inventory body scrolls as one list, allowing its filters and item controls to fit short viewports and larger text. Footer values wrap and tab labels scale down as needed. Original CRT painters and typography are preserved. Color opacity calls use `withValues`, requiring Flutter 3.27 or newer.
