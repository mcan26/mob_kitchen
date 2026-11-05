---
name: smart-kitchen-ble-wireless
description: >-
  Use this skill when building or modifying Bluetooth Low Energy (BLE) smart kitchen
  device integrations (smart meat thermometer, smart kitchen scale, ESP32 sensor nodes)
  or Wireless Local Network (Wi-Fi LAN WebSocket / UDP broadcast) multi-phone
  synchronization across Android and iOS in `lib/features/wireless/`.
---

# Smart Kitchen BLE & Wireless P2P Engineering Skill

This skill governs the cross-platform (Android + iOS) Bluetooth Low Energy (BLE) and Wireless LAN P2P subsystem in `lib/features/wireless/`.

## 1. Dual-Mode Architecture (Real Protocol + Live Physics Simulator)
For academic juries, engineering demonstrations, and real kitchen usage, every wireless feature must support **two seamless modes**:
1. **Real Protocol Mode (`dart:io` UDP Discovery + HTTP/WebSocket LAN Server & BLE GATT Payload Parser)**:
   - Runs a real HTTP + WebSocket server on port `8765` (with automatic fallback to an ephemeral port if busy) and UDP broadcast discovery on port `41234`.
   - Allows two physical phones (Android ↔ iOS) on the same Wi-Fi/Hotspot to sync `SupermarketScreen` checkoffs (`shopping_toggle`) and `CookModeScreen` steps/timers (`cook_step`) in real time.
   - Exposes `POST /telemetry` and WebSocket frames so physical **ESP32 / Arduino / Raspberry Pi** nodes can stream real temperature (`temp_c`) and load-cell weight (`weight_g`) JSON payloads directly into the app.
2. **Interactive Physics Simulator Mode (Jury / Presentation Mode)**:
   - Simulates BLE RSSI fluctuations (`-48 dBm` to `-67 dBm`), battery level, Newton's Law of Heating curve for the Smart Meat Thermometer ($T(t) = T_{\text{ambient}} + (T_0 - T_{\text{ambient}})e^{-kt}$), and load-cell pouring physics for the Smart Kitchen Scale.
   - Provides interactive buttons (*"Ateşi Yükselt"*, *"Malzeme Dök (+25g)"*, *"Dara Al (Tare)"*, *"Sanal Eş Telefon Simülasyonu"*) so live demonstrations work deterministically anywhere.

## 2. Standard BLE GATT & JSON Telemetry Payloads
- **Smart Meat Thermometer (`KitchenDeviceType.meatThermometer`)**:
  - Tracks internal core temperature (`currentTempC`), ambient/pan temperature (`ambientTempC`), target doneness (`targetTempC`), heating rate (`°C/min`), and estimated time to target (`ETA`).
- **Smart Kitchen Scale (`KitchenDeviceType.smartScale`)**:
  - Tracks current weight (`currentWeightGrams`), tare offset (`tareOffsetGrams`), target ingredient weight (`targetWeightGrams`), and stability flag (`isStable`).
- **Wireless Peer Sync (`PeerSyncMessage`)**:
  - JSON frame schema: `{"type": "shopping_toggle" | "cook_step" | "telemetry" | "ping", "sender": "...", "payload": {...}}`.
