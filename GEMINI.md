# Mob Kitchen — Project Rules & Engineering Standards

Mob Kitchen is an offline-first personal kitchen guide, smart supermarket assistant, and AI Sous-Chef built with **Flutter**, **Riverpod**, **GoRouter**, **Drift (SQLite)**, and **Google Gemini (`gemini-2.5-flash`)**.

## Core Architecture
- **Feature-First Clean Architecture**:
  - `lib/core/`: Database (`tables.dart`, `app_database.dart`), shared domain enums (`AisleCategory`, `MeasurementUnit`), theme (`MobColors`, `MobTheme`), router (`app_router.dart`).
  - `lib/features/recipes/`: Recipe catalog, `PortionScaler`, `DiscoveryFeedScreen`, `RecipeDetailScreen`.
  - `lib/features/shopping/`: `SmartShoppingAggregator`, `SupermarketScreen`, aisle-ordered reactive SQLite shopping list.
  - `lib/features/cooking/`: Hands-free `CookModeScreen` (wakelock, multi-timer `CookTimersNotifier`, `SousChefBottomSheet`).
  - `lib/features/ai/`: `GeminiRecipeService` (`generateRecipeFromPantry`, `importRecipeFromSocialOrText`, `remixRecipe`, `askSousChef`), strict JSON schema (`GeminiSchemas`).
  - `lib/features/profile/`: `PersonalTasteProfile` (equipment constraints, diet goals, allergies, disliked ingredients, spice level).
  - `lib/features/wireless/`: Cross-platform Android & iOS Bluetooth Low Energy (BLE GATT `0x181A` Thermometer & `0x181D` Smart Scale) + Wi-Fi LAN P2P Co-Op Sync (`LanSyncEngine`, `SmartKitchenHubScreen`) + ESP32 firmware (`iot_firmware/esp32_smart_kitchen_node.ino`).

## Installed Specialized Skills (`.agents/skills/`)
Always activate the relevant skill when working in its domain:
- `culinary-ux-design-system`: Editorial dark food UI, photography integration, kitchen distance ergonomics, onboarding taste quiz.
- `appstore-monetization-aso`: App Store Review compliance, RevenueCat/StoreKit 2 paywalls, freemium gating, viral growth loops, IP/trademark safety.
- `gemini-culinary-ai-architect`: Multimodal fridge/pantry photo vision, social URL/Reel recipe extraction, allergen safety checks, backend proxy architecture.
- `flutter-drift-clean-arch`: Wall-clock resilient timers, serving-size propagation, Drift migrations, test suite standards.
- `ios-kitchen-extensions`: Dynamic Island / Live Activities (`ActivityKit`), iOS Share Extension, voice hands-free Cook Mode.
- `smart-kitchen-ble-wireless`: Cross-platform Android & iOS BLE GATT (`0x181A`/`0x181D`), ESP32 sensor telemetry, and Wi-Fi LAN P2P Co-Op sync.
- `smart-kitchen-ble-wireless`: Cross-platform Android & iOS Bluetooth (BLE) smart thermometer/scale telemetry, ESP32 sensor bridge, and Wi-Fi LAN P2P multi-phone synchronization (`lib/features/wireless/`).
