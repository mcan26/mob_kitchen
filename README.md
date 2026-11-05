# Mob Kitchen

Kişisel, offline-first mutfak rehberi, akıllı süpermarket asistanı ve Gemini 2.5 Flash destekli canlı Sous-Chef (Flutter · Riverpod · GoRouter · Drift · Gemini).

## Kurulum & Doğrulama

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs  # Drift kodunu üretir
flutter analyze
flutter test
flutter run
```

## Mimari (Feature-First Clean Architecture)

```text
lib/
├── main.dart / app.dart
├── core/
│   ├── database/        # Drift: tables.dart, app_database.dart, converters.dart
│   ├── domain/          # Paylaşılan enum'lar: AisleCategory, MeasurementUnit
│   ├── providers/       # appDatabase, sharedPreferences
│   ├── router/          # GoRouter (/ , /recipe/:id, /pantry, /cook/:id, /shopping, /profile)
│   └── theme/           # MobColors, MobTheme, RecipeVisuals (editorial görsel kimlik & alerjen kontrolü)
└── features/
    ├── recipes/         # Mob Classics kataloğu, PortionScaler, DiscoveryFeedScreen, RecipeDetailScreen
    ├── shopping/        # SmartShoppingAggregator, SupermarketScreen (reyon sıralı + panoya kopyalama)
    ├── cooking/         # CookModeScreen (wakelock, arka plan duvar saati senkronlu CookTimersNotifier, SousChef)
    ├── profile/         # PersonalTasteProfile & TasteProfileScreen (ekipman, alerji, acı, API/gizlilik ayarları)
    ├── subscription/    # ChefProPaywallSheet, SubscriptionNotifier (Freemium 3 ücretsiz AI hakkı + Chef Pro)
    └── ai/              # GeminiRecipeService (Buzdolabı Fotoğraf Vizyonu, Reels/TikTok Tarif Aktarıcı, AI Remix, Sous-Chef)
```

## Öne Çıkan Mühendislik ve Ürün Özellikleri

- **Buzdolabı Fotoğrafından Tarif (Multimodal Gemini Vision) & Sosyal Medya (Reels/TikTok) Aktarıcı:**
  - [`PantryGeneratorScreen`](lib/features/ai/presentation/pantry_generator_screen.dart) üzerinden kamera/galeri ile buzdolabı fotoğrafı çekerek veya Instagram Reels / TikTok / Web tarif linkini yapıştırarak anında yapılandırılmış Mob reçetesi oluşturma.
- **Kişisel Mutfak Profili & Alerjen Güvenlik Kalkanı:**
  - [`TasteProfileScreen`](lib/features/profile/presentation/taste_profile_screen.dart) ile mutfak ekipmanları (*Fırınsız Mod* dahil), beslenme hedefleri, hayati alerjiler, sevmediğiniz malzemeler ve acı toleransı yönetimi.
  - Tarif detayında [`RecipeVisuals.findAllergenOrDislikeWarnings`](lib/core/theme/recipe_visuals.dart) ile deterministik alerjen uyarısı.
- **Arka Planda Kaymayan Pişirme Sayaçları & Porsiyon Taşıma (`CookModeScreen`):**
  - [`CookTimersNotifier`](lib/features/cooking/providers/cook_timer_provider.dart) gerçek duvar saati (`targetEndTime`) ve `WidgetsBindingObserver` (`AppLifecycleState.resumed`) senkronizasyonuyla iOS arka plana geçse bile süreyi saniyesi saniyesine korur.
  - Tarif detayında seçilen porsiyon (`?servings=`) pişirme ekranındaki adım içi malzeme barına otomatik taşınır.
- **Chef Pro Freemium & Abonelik Mimarisi:**
  - [`ChefProPaywallSheet`](lib/features/subscription/presentation/chef_pro_paywall_sheet.dart) ile 3 ücretsiz AI deneme hakkı, yıllık/aylık abonelik seçenekleri ve App Store Guideline 3.1.1 uyumlu "Satın Alımları Geri Yükle" akışı.
- **Android & iOS Çapraz Platform Bluetooth (BLE 5.0) + Kablosuz Yerel Ağ (Wi-Fi LAN Co-Op) Akıllı Mutfak Hub:**
  - [`SmartKitchenHubScreen`](lib/features/wireless/presentation/smart_kitchen_hub_screen.dart) ve [`LanSyncEngine`](lib/features/wireless/data/lan_sync_engine.dart) ile:
    - **BLE GATT `0x181A` & `0x2A6E` Akıllı Et/Tava Termometresi:** 0.01°C çözünürlüklü 16-bit Little-Endian binary payload çözücü, Sous-Vide / Steak / Karamelizasyon hedef sıcaklık ön ayarları ve Newton'un Isınma Yasası tabanlı canlı termal eğri simülatörü.
    - **BLE GATT `0x181D` & `0x2A9D` Akıllı Mutfak Tartısı:** 0.1 g (100 mg) çözünürlüklü ağırlık paketi çözücü, canlı Dara Sıfırlama (*Tare*) ve gramaj hedef barı.
    - **Android ↔ iOS Wi-Fi LAN Co-Op P2P & UDP Broadcast (`41234`) MANET Senkronizasyonu:** Saf `dart:io` (`HttpServer` + çift yönlü `WebSocket` + `RawDatagramSocket` UDP Broadcast sıfır-konfigürasyonlu MANET keşfi) ve yerel `com.mobkitchen/native_network` (`ConnectivityManager` / `WifiManager` / `BluetoothManager`) köprüsü ile aynı Wi-Fi'daki telefonlar arasında market sepeti tiklerini ve pişirme adımlarını bulut sunucusuna ihtiyaç duymadan milisaniyeler içinde senkronize etme.
    - **ESP32 Donanım Kodu:** [`iot_firmware/esp32_smart_kitchen_node.ino`](iot_firmware/esp32_smart_kitchen_node.ino) dosyasında gerçek ESP32 + DS18B20 + HX711 Load Cell kurulumu için hazır C++/Arduino BLE & Wi-Fi firmware kodu.
