---
name: flutter-drift-clean-arch
description: >-
  Use this skill when modifying database schemas, repositories, domain services,
  Riverpod providers, background timers, or tests in the Mob Kitchen Flutter codebase.
---

# Flutter + Drift + Riverpod Systems Engineering Skill

This skill ensures rock-solid systems engineering across `lib/core/` and `lib/features/`.

## 1. Architecture & Layer Boundaries
- **Domain Layer (`domain/`)**: Pure Dart entities (`Equatable`), enums, repository interfaces, and deterministic domain services ([`PortionScaler`](file:///Users/can/Desktop/mob_kitchen/lib/features/recipes/domain/services/portion_scaler.dart), [`SmartShoppingAggregator`](file:///Users/can/Desktop/mob_kitchen/lib/features/shopping/domain/services/smart_shopping_aggregator.dart)). Zero Flutter UI or SQLite imports.
- **Data Layer (`data/`)**: Drift tables ([`tables.dart`](file:///Users/can/Desktop/mob_kitchen/lib/core/database/tables.dart)), mappers, seeders, and repository implementations.
- **Presentation Layer (`presentation/`)**: `ConsumerWidget` / `ConsumerStatefulWidget` reading reactive Riverpod providers.

## 2. Critical Engineering Patterns & Bug Prevention
1. **Wall-Clock Resilient Cooking Timers**:
   - `Timer.periodic` in Dart isolates pauses when iOS suspends the app in the background.
   - Always store `DateTime? targetEndTime` on [`ActiveTimerState`](file:///Users/can/Desktop/mob_kitchen/lib/features/cooking/providers/cook_timer_provider.dart) and compute `remainingSeconds = targetEndTime.difference(DateTime.now()).inSeconds` on tick and on `AppLifecycleState.resumed`.
   - Schedule an OS-level local notification (`flutter_local_notifications`) for `targetEndTime` so the user's food never burns if they lock their phone or switch to Spotify/Instagram while cooking!
2. **Propagating `targetServings` into `CookModeScreen`**:
   - When a user scales servings in [`RecipeDetailScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/recipes/presentation/recipe_detail_screen.dart) (e.g., from 2 to 4 servings) and taps "Pişirmeye Başla", pass `?servings=$currentServings` to `/cook/:id` so `_InStepIngredientsBar` scales ingredient quantities to match!
3. **Smart Ingredient Aggregation Normalization**:
   - In [`SmartShoppingAggregator`](file:///Users/can/Desktop/mob_kitchen/lib/features/shopping/domain/services/smart_shopping_aggregator.dart), strip Turkish suffixes, parenthetical notes, and punctuation, and map synonyms (e.g., `"Sarımsak (ezilmiş)"` and `"Sarımsak"` -> `"sarımsak"`) so identical ingredients never split into duplicate rows.

## 3. Verification & Code Generation Commands
- Regenerate Drift code after editing `tables.dart` or `app_database.dart`:
  `dart run build_runner build --delete-conflicting-outputs`
- Run static analysis and full test suite before completing any task:
  `flutter analyze && flutter test`
