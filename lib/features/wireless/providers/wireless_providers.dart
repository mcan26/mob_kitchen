import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shopping/providers/shopping_providers.dart';
import '../data/lan_sync_engine.dart';
import '../domain/entities/smart_kitchen_device.dart';

class SmartKitchenHubNotifier extends StateNotifier<SmartKitchenHubState> {
  SmartKitchenHubNotifier(this._ref)
      : _engine = LanSyncAndBleCodecEngine(),
        super(
          const SmartKitchenHubState(
            devices: _defaultCatalogDevices,
          ),
        ) {
    _engine.onPacketReceived = _handleIncomingWirelessPacket;
    _engine.onClientCountChanged = _handleClientCountChanged;
    _engine.onPeerDiscovered = _handleUdpPeerDiscovered;
  }

  static const MethodChannel nativeNetworkChannel =
      MethodChannel('com.mobkitchen/native_network');

  final Ref _ref;
  final LanSyncAndBleCodecEngine _engine;
  Timer? _telemetryTicker;
  final math.Random _rng = math.Random(42);

  static const List<SmartKitchenDevice> _defaultCatalogDevices = [
    SmartKitchenDevice(
      id: 'ble_probe_01',
      name: 'MobProbe Pro (BLE Et & Tava Termometresi)',
      type: KitchenDeviceType.meatThermometer,
      protocol: WirelessProtocol.bleGatt,
      rssiDbm: -52,
      batteryPercent: 94,
      macOrIpAddress: 'AA:BB:CC:18:1A:01',
      isConnected: false,
      isSimulated: true,
    ),
    SmartKitchenDevice(
      id: 'ble_scale_01',
      name: 'MobScale Precision (BLE Akıllı Tartı)',
      type: KitchenDeviceType.smartScale,
      protocol: WirelessProtocol.bleGatt,
      rssiDbm: -58,
      batteryPercent: 87,
      macOrIpAddress: 'AA:BB:CC:18:1D:02',
      isConnected: false,
      isSimulated: true,
    ),
    SmartKitchenDevice(
      id: 'esp32_kitchen_01',
      name: 'ESP32-S3 Smart Kitchen Sensor Node',
      type: KitchenDeviceType.esp32SensorNode,
      protocol: WirelessProtocol.wifiLan,
      rssiDbm: -61,
      batteryPercent: 100,
      macOrIpAddress: '192.168.1.108:8765',
      isConnected: false,
      isSimulated: true,
    ),
    SmartKitchenDevice(
      id: 'peer_phone_01',
      name: 'Sous-Chef Telefonu (iPhone / Android Co-Op)',
      type: KitchenDeviceType.peerPhone,
      protocol: WirelessProtocol.wifiLan,
      rssiDbm: -49,
      batteryPercent: 78,
      macOrIpAddress: '192.168.1.55:8765',
      isConnected: false,
      isSimulated: true,
    ),
  ];

  void _handleClientCountChanged(int wsClientCount) {
    if (!mounted) return;
    final peerConnectedCount = state.devices
        .where((d) => d.isConnected && d.type == KitchenDeviceType.peerPhone)
        .length;
    state = state.copyWith(
      connectedPeerCount: math.max(peerConnectedCount, wsClientCount),
    );
  }

  /// Android (`ConnectivityManager` / `WifiManager` / `BluetoothManager`) ve iOS
  /// yerel ağ tanılama kanalını (`com.mobkitchen/native_network`) sorgular.
  Future<NativeNetworkDiagnostics> refreshNativeNetworkDiagnostics() async {
    try {
      final raw = await nativeNetworkChannel
          .invokeMapMethod<String, dynamic>('getNativeNetworkDiagnostics');
      if (raw != null && raw.isNotEmpty) {
        final diag = NativeNetworkDiagnostics.fromMap(
          raw,
          isFromNativeChannel: true,
        );
        if (mounted) {
          final ip = diag.ipv4Address.isNotEmpty && diag.ipv4Address != '127.0.0.1'
              ? diag.ipv4Address
              : state.localIpAddress;
          state = state.copyWith(
            nativeDiagnostics: diag,
            localIpAddress: ip,
          );
        }
        return diag;
      }
    } catch (_) {
      // Test ortamı veya emülatör fallback
    }

    final ip = await LanSyncAndBleCodecEngine.resolveLocalIpv4();
    final fallback = state.nativeDiagnostics.copyWith(
      ipv4Address: ip,
      isFromNativeChannel: false,
    );
    if (mounted) {
      state = state.copyWith(
        nativeDiagnostics: fallback,
        localIpAddress: ip,
      );
    }
    return fallback;
  }

  /// BLE ve yerel Wi-Fi cihazlarını tarar, ayrıca yerel işletim sistemi ağ tanılamasını günceller.
  Future<void> scanForDevices() async {
    if (state.isScanning) return;
    state = state.copyWith(isScanning: true);

    final diag = await refreshNativeNetworkDiagnostics();
    if (_engine.isUdpDiscoveryRunning) {
      _engine.sendUdpBeacon(
        localIp: diag.ipv4Address,
        lanPort: state.lanPort,
        roomCode: state.roomCode,
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    // RSSI sinyal gücünü gerçekçi biçimde güncelle
    final refreshed = state.devices.map((d) {
      final jitter = _rng.nextInt(5) - 2;
      return d.copyWith(rssiDbm: (d.rssiDbm + jitter).clamp(-85, -42));
    }).toList();

    state = state.copyWith(
      isScanning: false,
      localIpAddress: diag.ipv4Address,
      devices: refreshed,
    );
  }

  /// UDP Broadcast (Port 41234) üzerinden keşfedilen MANET eş düğümünü işler ve otomatik bağlar.
  Future<void> handleUdpBeaconDiscovered(Map<String, dynamic> beacon) async {
    await _handleUdpPeerDiscovered(beacon);
  }

  Future<void> _handleUdpPeerDiscovered(Map<String, dynamic> beacon) async {
    if (!mounted) return;
    final ip = beacon['ip']?.toString() ?? '192.168.1.99';
    final port = (beacon['port'] as num?)?.toInt() ?? 8765;
    final room = beacon['room']?.toString() ?? state.roomCode;
    final deviceName = beacon['device']?.toString() ?? 'MANET Eş Telefon';
    final endpoint = '$ip:$port';
    final isNewPeer = !state.discoveredPeers.contains(endpoint);

    final updatedPeers = <String>{...state.discoveredPeers, endpoint}.toList();
    final updatedDevices = state.devices.map((d) {
      if (d.id == 'peer_phone_01') {
        return d.copyWith(
          macOrIpAddress: endpoint,
          isConnected: true,
        );
      }
      return d;
    }).toList();

    final peerConnectedCount = updatedDevices
        .where((d) => d.isConnected && d.type == KitchenDeviceType.peerPhone)
        .length;

    final nextEvents = isNewPeer
        ? [
            WirelessSyncEvent(
              id: 'udp_${DateTime.now().microsecondsSinceEpoch}',
              type: 'udp_beacon',
              senderDevice: '$deviceName ($endpoint)',
              description:
                  'UDP Broadcast (Port 41234) MANET keşfi: Oda $room üzerinde eş cihaz bulundu ve otomatik bağlandı.',
              timestamp: DateTime.now(),
            ),
            ...state.syncEvents.take(19),
          ]
        : state.syncEvents;

    state = state.copyWith(
      devices: updatedDevices,
      discoveredPeers: updatedPeers,
      connectedPeerCount: math.max(peerConnectedCount, _engine.connectedClientsCount),
      syncEvents: nextEvents,
    );

    unawaited(_engine.connectToPeerWebSocket(ip, port));
  }

  /// Bir BLE veya Wi-Fi cihazının bağlantısını açar/kapatır.
  void toggleDeviceConnection(String deviceId) {
    final updated = state.devices.map((d) {
      if (d.id == deviceId) {
        return d.copyWith(isConnected: !d.isConnected);
      }
      return d;
    }).toList();

    final peerConnectedCount = updated
        .where((d) => d.isConnected && d.type == KitchenDeviceType.peerPhone)
        .length;

    final toggledDevice = updated.firstWhere((d) => d.id == deviceId);
    final event = WirelessSyncEvent(
      id: 'evt_${DateTime.now().microsecondsSinceEpoch}',
      type: toggledDevice.isConnected ? 'connect' : 'disconnect',
      senderDevice: toggledDevice.name,
      description: toggledDevice.isConnected
          ? '${toggledDevice.protocol.badge} üzerinden bağlantı kuruldu (${toggledDevice.rssiDbm} dBm).'
          : 'Cihaz bağlantısı sonlandırıldı.',
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      devices: updated,
      connectedPeerCount: math.max(peerConnectedCount, _engine.connectedClientsCount),
      syncEvents: [event, ...state.syncEvents.take(19)],
    );

    try {
      HapticFeedback.mediumImpact();
    } catch (_) {}

    _ensureTelemetryLoop();
  }

  void _ensureTelemetryLoop() {
    if (state.hasConnectedThermometer || state.hasConnectedScale) {
      if (_telemetryTicker == null || !_telemetryTicker!.isActive) {
        _telemetryTicker = Timer.periodic(const Duration(seconds: 1), (_) {
          _tickSimulatedPhysics();
        });
      }
    } else {
      _telemetryTicker?.cancel();
      _telemetryTicker = null;
    }
  }

  /// Newton'un Isınma Yasası (Newton's Law of Heating) ile gerçekçi termometre fiziği:
  /// dT/dt = k * (T_ambient - T_current)
  void _tickSimulatedPhysics() {
    if (!mounted || !state.simulationModeEnabled) return;

    var nextThermo = state.thermometer;
    if (state.hasConnectedThermometer) {
      final current = nextThermo.currentTempC;
      final ambient = nextThermo.ambientTempC;
      // Isı transfer katsayısı
      const k = 0.018;
      final delta = (ambient - current) * k;
      final newTemp = double.parse((current + delta).clamp(20.0, 220.0).toStringAsFixed(1));
      final ratePerMin = double.parse((delta * 60).clamp(0.0, 45.0).toStringAsFixed(1));
      final nextHistory = [...nextThermo.history.skip(math.max(0, nextThermo.history.length - 23)), newTemp];

      nextThermo = nextThermo.copyWith(
        currentTempC: newTemp,
        rateCPerMinute: ratePerMin,
        history: nextHistory,
      );
    }

    // RSSI canlı ufak dalgalanma
    final updatedDevices = state.devices.map((d) {
      if (!d.isConnected) return d;
      final delta = _rng.nextInt(3) - 1;
      return d.copyWith(rssiDbm: (d.rssiDbm + delta).clamp(-80, -44));
    }).toList();

    state = state.copyWith(
      thermometer: nextThermo,
      devices: updatedDevices,
    );
  }

  /// Pişirme hedefi sıcaklığını değiştirir (örn. 56°C Steak, 74°C Tavuk).
  void applyTempPreset(CulinaryTempPreset preset) {
    state = state.copyWith(
      thermometer: state.thermometer.copyWith(
        targetTempC: preset.targetTempC,
        ambientTempC: preset.recommendedPanTempC,
      ),
    );
  }

  void setCustomTargetTemp(double targetC) {
    state = state.copyWith(
      thermometer: state.thermometer.copyWith(targetTempC: targetC),
    );
  }

  /// Sunum / Jüri demosu için ocağın ısısını veya çekirdek sıcaklığı anlık artırır.
  void simulateHeatBurst({double deltaC = 6.5}) {
    final nextTemp = double.parse(
      (state.thermometer.currentTempC + deltaC).clamp(20.0, 210.0).toStringAsFixed(1),
    );
    final nextHistory = [
      ...state.thermometer.history.skip(math.max(0, state.thermometer.history.length - 23)),
      nextTemp,
    ];
    state = state.copyWith(
      thermometer: state.thermometer.copyWith(
        currentTempC: nextTemp,
        rateCPerMinute: 14.5,
        history: nextHistory,
      ),
    );
  }

  void resetThermometerToRoomTemp() {
    state = state.copyWith(
      thermometer: state.thermometer.copyWith(
        currentTempC: 23.5,
        rateCPerMinute: 6.0,
        history: const [23.0, 23.5],
      ),
    );
  }

  /// Akıllı tartıda Dara Al (Tare / 0.0g sıfırlama) işlemi.
  void tareScale() {
    state = state.copyWith(
      scale: state.scale.copyWith(
        tareOffsetGrams: state.scale.rawWeightGrams,
        isStable: true,
      ),
    );
  }

  /// Akıllı tartıya malzeme ekleme simülasyonu (veya gerçek sensör güncellemesi).
  void pourIngredientOnScale(double addedGrams) {
    final nextRaw = (state.scale.rawWeightGrams + addedGrams).clamp(0.0, 5000.0);
    state = state.copyWith(
      scale: state.scale.copyWith(
        rawWeightGrams: double.parse(nextRaw.toStringAsFixed(1)),
        isStable: true,
      ),
    );
  }

  void setScaleTarget({required double targetGrams, required String ingredientName}) {
    state = state.copyWith(
      scale: state.scale.copyWith(
        targetWeightGrams: targetGrams,
        targetIngredientName: ingredientName,
      ),
    );
  }

  /// Gerçek yerel Wi-Fi (HTTP + WebSocket) sunucusunu ve UDP Broadcast (Port 41234)
  /// MANET keşif servisini başlatır veya durdurur.
  Future<void> toggleLanCoOpServer() async {
    if (state.isLanHostRunning) {
      try {
        await nativeNetworkChannel.invokeMethod<bool>(
          'setMulticastLock',
          const <String, dynamic>{'enabled': false},
        );
      } catch (_) {}
      await _engine.stopServer();
      state = state.copyWith(
        isLanHostRunning: false,
        isUdpDiscoveryActive: false,
      );
      return;
    }

    try {
      await nativeNetworkChannel.invokeMethod<bool>(
        'setMulticastLock',
        const <String, dynamic>{'enabled': true},
      );
    } catch (_) {}

    final nativeIp = state.nativeDiagnostics.ipv4Address;
    final hasNativeLanIp = state.nativeDiagnostics.isFromNativeChannel &&
        nativeIp.isNotEmpty &&
        nativeIp != '127.0.0.1';
    final ip = hasNativeLanIp
        ? nativeIp
        : await LanSyncAndBleCodecEngine.resolveLocalIpv4();
    final port = await _engine.startServer(preferredPort: 8765);
    final udpActive = await _engine.startUdpDiscovery(
      localIp: ip,
      lanPort: port,
      roomCode: state.roomCode,
    );
    final event = WirelessSyncEvent(
      id: 'lan_${DateTime.now().microsecondsSinceEpoch}',
      type: 'lan_host',
      senderDevice: 'Bu Telefon ($ip:$port)',
      description:
          'Wi-Fi P2P Sunucusu (HTTP/WS :$port) ve UDP MANET Broadcast (:41234) başlatıldı.',
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      isLanHostRunning: true,
      isUdpDiscoveryActive: udpActive,
      localIpAddress: ip,
      lanPort: port,
      syncEvents: [event, ...state.syncEvents.take(19)],
    );
  }

  /// Gelen kablosuz paketi doğrudan işlemek için dışa açık yardımcı metot.
  Future<void> processIncomingPacket(Map<String, dynamic> packet) =>
      _handleIncomingWirelessPacket(packet);

  /// Gerçek HTTP/WebSocket üzerinden gelen telemetri, market veya pişirme senkron paketini işler.
  Future<void> _handleIncomingWirelessPacket(Map<String, dynamic> packet) async {
    final nestedPayload = packet['payload'] is Map
        ? Map<String, dynamic>.from(packet['payload'] as Map)
        : const <String, dynamic>{};
    final data = <String, dynamic>{...nestedPayload, ...packet};

    final type = data['type'] as String? ?? 'telemetry';
    final sender = data['sender'] as String? ?? 'Uzak Cihaz';

    if (type == 'telemetry' || data.containsKey('temp_c') || data.containsKey('weight_g')) {
      final tempC = (data['temp_c'] as num?)?.toDouble();
      final ambientC = (data['ambient_c'] as num?)?.toDouble();
      final weightG = (data['weight_g'] as num?)?.toDouble();

      var nextThermo = state.thermometer;
      if (tempC != null) {
        nextThermo = nextThermo.copyWith(
          currentTempC: tempC,
          ambientTempC: ambientC ?? nextThermo.ambientTempC,
          history: [...nextThermo.history.skip(math.max(0, nextThermo.history.length - 23)), tempC],
        );
      }

      var nextScale = state.scale;
      if (weightG != null) {
        nextScale = nextScale.copyWith(rawWeightGrams: weightG, isStable: true);
      }

      state = state.copyWith(
        thermometer: nextThermo,
        scale: nextScale,
        syncEvents: [
          WirelessSyncEvent(
            id: 'pkt_${DateTime.now().microsecondsSinceEpoch}',
            type: 'telemetry',
            senderDevice: sender,
            description:
                'Canlı telemetri alındı: ${tempC != null ? "${tempC.toStringAsFixed(1)}°C " : ""}${weightG != null ? "${weightG.toStringAsFixed(0)}g" : ""}',
            timestamp: DateTime.now(),
          ),
          ...state.syncEvents.take(19),
        ],
      );
      return;
    }

    if (type == 'shopping_toggle' || type == 'shopping_item_toggle') {
      final itemId = (data['item_id'] ?? data['itemId'])?.toString();
      final itemName =
          (data['item_name'] ?? data['name'] ?? data['item_Name'])?.toString() ?? 'Ürün';
      final explicitChecked = (data['checked'] ?? data['is_checked']) as bool?;
      if (itemId != null && itemId.isNotEmpty) {
        try {
          final repo = _ref.read(shoppingRepositoryProvider);
          if (explicitChecked != null) {
            await repo.setItemChecked(itemId, explicitChecked);
          } else {
            await repo.toggleItemChecked(itemId);
          }
        } catch (_) {}
      }

      final description = data['description']?.toString() ??
          '"$itemName" market listesinde eşzamanlı işaretlendi!';

      state = state.copyWith(
        syncEvents: [
          WirelessSyncEvent(
            id: 'sync_${DateTime.now().microsecondsSinceEpoch}',
            type: type,
            senderDevice: sender,
            description: description,
            timestamp: DateTime.now(),
          ),
          ...state.syncEvents.take(19),
        ],
      );
      return;
    }

    if (type == 'cook_step_sync' || type == 'cook_step') {
      final recipeId = (data['recipeId'] ?? data['recipe_id'])?.toString() ?? 'recipe';
      final stepIndex = ((data['stepIndex'] ?? data['step_index']) as num?)?.toInt() ?? 1;
      final totalSteps = ((data['totalSteps'] ?? data['total_steps']) as num?)?.toInt() ?? 1;
      final description = data['description']?.toString() ??
          'Co-Op Pişirme Senkronu ($recipeId): Adım $stepIndex/$totalSteps';

      state = state.copyWith(
        lastSyncedCookStep: '$recipeId:$stepIndex/$totalSteps',
        syncEvents: [
          WirelessSyncEvent(
            id: 'cook_${DateTime.now().microsecondsSinceEpoch}',
            type: 'cook_step_sync',
            senderDevice: sender,
            description: description,
            timestamp: DateTime.now(),
          ),
          ...state.syncEvents.take(19),
        ],
      );
    }
  }

  /// İkinci bir telefondan (Android/iOS partner) canlı market veya pişirme senkronu
  /// gelmiş gibi gerçek SQLite veritabanını güncelleyen demo aksiyonu.
  Future<void> simulatePeerShoppingSync() async {
    try {
      final items = _ref.read(shoppingListItemsProvider).valueOrNull;
      if (items != null && items.isNotEmpty) {
        final unchecked = items.where((i) => !i.isChecked).firstOrNull ?? items.firstOrNull;
        if (unchecked != null) {
          await _handleIncomingWirelessPacket({
            'type': 'shopping_toggle',
            'sender': 'Sous-Chef iPhone (Wi-Fi LAN)',
            'item_id': unchecked.id,
            'item_name': unchecked.name,
          });
          return;
        }
      }
    } catch (_) {}

    await _handleIncomingWirelessPacket({
      'type': 'shopping_toggle',
      'sender': 'Sous-Chef Android (Wi-Fi LAN)',
      'item_name': 'Sarımsak (Manav Reyonu)',
    });
  }

  /// İkinci bir telefondan (Android/iOS partner) canlı Pişirme Modu (Cook Mode)
  /// adım geçişi (`cook_step_sync`) gelmiş gibi durumu ve paket günlüğünü güncelleyen demo aksiyonu.
  Future<void> simulatePeerCookStepSync() async {
    const recipeId = 'spicy_vodka_rigatoni';
    const totalSteps = 4;
    var nextStep = 1;
    final current = state.lastSyncedCookStep;
    if (current != null && current.contains(':')) {
      final stepPart = current.split(':').last.split('/').first;
      final parsed = int.tryParse(stepPart) ?? 0;
      nextStep = (parsed % totalSteps) + 1;
    }
    await _handleIncomingWirelessPacket({
      'type': 'cook_step_sync',
      'sender': 'Sous-Chef Pixel 9 Pro (Wi-Fi LAN)',
      'recipeId': recipeId,
      'stepIndex': nextStep,
      'totalSteps': totalSteps,
      'description':
          'Co-Op Cook Mode Sync ($recipeId): Step $nextStep/$totalSteps (Adım $nextStep/$totalSteps)',
    });
  }

  /// Başka bir telefonun IP:Port adresine çift yönlü WebSocket ve HTTP `/sync`
  /// üzerinden senkronizasyon el sıkışması (handshake) gönderir.
  Future<bool> sendSyncPingToPeer(String ipAndPort) async {
    final parts = ipAndPort.trim().split(':');
    final host = parts.first;
    final port = parts.length > 1 ? (int.tryParse(parts[1]) ?? 8765) : 8765;

    final payload = <String, dynamic>{
      'type': 'shopping_toggle',
      'sender': 'Mob Kitchen (${state.localIpAddress})',
      'item_name': 'Canlı Co-Op El Sıkışma (Handshake)',
    };

    final wsOk = await _engine.connectToPeerWebSocket(host, port);
    bool ok = wsOk;
    if (wsOk) {
      _engine.broadcastJson(payload);
    } else {
      ok = await _engine.sendPacketToPeerHttp(
        hostIp: host,
        port: port,
        payload: payload,
      );
    }

    final event = WirelessSyncEvent(
      id: 'ping_${DateTime.now().microsecondsSinceEpoch}',
      type: ok ? 'peer_ok' : 'peer_sim',
      senderDevice: '$host:$port',
      description: ok
          ? 'Hedef cihazla çift yönlü WebSocket/HTTP el sıkışması başarılı!'
          : 'Paket yerel ağa yayınlandı (Simülasyon Onayı: $host:$port).',
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      syncEvents: [event, ...state.syncEvents.take(19)],
    );
    return ok;
  }

  /// Yerel Wi-Fi P2P ağına canlı bir Co-Op olayı (market tiki veya pişirme adımı) yayınlar.
  void broadcastCoOpEvent(
    String type,
    String description, {
    Map<String, dynamic>? payload,
  }) {
    final packet = <String, dynamic>{
      'type': type,
      'sender': 'Mob Kitchen (${state.localIpAddress})',
      'description': description,
      if (payload != null) ...payload,
    };
    _engine.broadcastJson(packet);

    final event = WirelessSyncEvent(
      id: 'coop_${DateTime.now().microsecondsSinceEpoch}',
      type: type,
      senderDevice: 'Bu Telefon (${state.localIpAddress})',
      description: description,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      syncEvents: [event, ...state.syncEvents.take(19)],
    );
  }

  @override
  void dispose() {
    _telemetryTicker?.cancel();
    _engine.stopServer();
    super.dispose();
  }
}

final smartKitchenHubProvider =
    StateNotifierProvider<SmartKitchenHubNotifier, SmartKitchenHubState>((ref) {
  return SmartKitchenHubNotifier(ref);
});
