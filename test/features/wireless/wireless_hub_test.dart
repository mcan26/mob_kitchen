import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/features/shopping/domain/entities/shopping_list_item.dart';
import 'package:mob_kitchen/features/shopping/domain/repositories/shopping_repository.dart';
import 'package:mob_kitchen/features/shopping/domain/services/smart_shopping_aggregator.dart';
import 'package:mob_kitchen/features/shopping/providers/shopping_providers.dart';
import 'package:mob_kitchen/features/wireless/data/lan_sync_engine.dart';
import 'package:mob_kitchen/features/wireless/domain/entities/smart_kitchen_device.dart';
import 'package:mob_kitchen/features/wireless/presentation/smart_kitchen_hub_screen.dart';
import 'package:mob_kitchen/features/wireless/providers/wireless_providers.dart';

class _FakeShoppingRepository implements ShoppingRepository {
  String? lastToggledItemId;
  String? lastSetItemId;
  bool? lastSetCheckedValue;

  @override
  Stream<List<ShoppingListItem>> watchItems() => Stream.value(const []);

  @override
  Stream<List<ShoppingPlanEntry>> watchPlan() => Stream.value(const []);

  @override
  Future<void> toggleItemChecked(String itemId) async {
    lastToggledItemId = itemId;
  }

  @override
  Future<void> setItemChecked(String itemId, bool isChecked) async {
    lastSetItemId = itemId;
    lastSetCheckedValue = isChecked;
  }

  @override
  Future<void> addOrUpdateRecipeInPlan(String recipeId, int servings) async {}

  @override
  Future<void> removeRecipeFromPlan(String recipeId) async {}

  @override
  Future<void> clearCheckedItems() async {}

  @override
  Future<void> clearPlan() async {}
}

void main() {
  group('BLE GATT 0x181A & 0x181D Binary Payload Codecs & UDP MANET Beacons', () {
    test('encodes and decodes BLE GATT 0x2A6E Temperature (0.01°C int16 little-endian)', () {
      final bytes = LanSyncAndBleCodecEngine.encodeBleTemperatureBytes(54.25);
      expect(bytes.length, 2);
      final decoded = LanSyncAndBleCodecEngine.decodeBleTemperatureBytes(bytes);
      expect(decoded, closeTo(54.25, 0.01));

      // Negative temperature edge case (-18.50°C freezer)
      final negBytes = LanSyncAndBleCodecEngine.encodeBleTemperatureBytes(-18.50);
      expect(LanSyncAndBleCodecEngine.decodeBleTemperatureBytes(negBytes), closeTo(-18.50, 0.01));

      // Malformed short payload throws FormatException
      expect(
        () => LanSyncAndBleCodecEngine.decodeBleTemperatureBytes(const [0x01]),
        throwsFormatException,
      );
    });

    test('encodes and decodes BLE GATT 0x2A9D Scale Weight (0.1g / 100mg resolution)', () {
      final bytes = LanSyncAndBleCodecEngine.encodeBleScaleWeightBytes(125.4);
      expect(bytes.length, 3);
      final decoded = LanSyncAndBleCodecEngine.decodeBleScaleWeightBytes(bytes);
      expect(decoded, closeTo(125.4, 0.1));

      expect(
        () => LanSyncAndBleCodecEngine.decodeBleScaleWeightBytes(const [0x00, 0x10]),
        throwsFormatException,
      );
    });

    test('encodes and decodes UDP Broadcast (Port 41234) MANET discovery beacon and rejects invalid data', () {
      final encoded = LanSyncAndBleCodecEngine.encodeUdpBeaconBytes(
        ip: '192.168.1.77',
        port: 8765,
        room: 'MOB-2026',
        device: 'Pixel 9 Pro',
      );
      final decoded = LanSyncAndBleCodecEngine.tryDecodeUdpBeaconBytes(encoded);
      expect(decoded, isNotNull);
      expect(decoded!['type'], 'mob_beacon');
      expect(decoded['ip'], '192.168.1.77');
      expect(decoded['port'], 8765);
      expect(decoded['room'], 'MOB-2026');
      expect(decoded['device'], 'Pixel 9 Pro');

      // Non-beacon or malformed bytes return null safely
      expect(LanSyncAndBleCodecEngine.tryDecodeUdpBeaconBytes(const [0xFF, 0x00]), isNull);
      expect(
        LanSyncAndBleCodecEngine.tryDecodeUdpBeaconBytes('{"type":"other"}'.codeUnits),
        isNull,
      );
    });

    test('computes directed /24 subnet broadcast address for Android wlan0/ap0 routing', () {
      expect(
        LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('192.168.1.77'),
        '192.168.1.255',
      );
      expect(
        LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('10.0.2.15'),
        '10.0.2.255',
      );
      expect(
        LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('172.20.10.2'),
        '172.20.10.255',
      );
      expect(LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('127.0.0.1'), isNull);
      expect(LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('255.255.255.255'), isNull);
      expect(LanSyncAndBleCodecEngine.computeSubnetBroadcastAddress('invalid'), isNull);
    });
  });

  group('Two-Phone Full-Duplex WebSocket & HTTP Fallback P2P Engine', () {
    setUp(() {
      HttpOverrides.global = null;
    });

    test('establishes full-duplex WebSocket connection between two nodes and relays packets both ways', () async {
      final hostEngine = LanSyncAndBleCodecEngine();
      final clientEngine = LanSyncAndBleCodecEngine();
      addTearDown(() async {
        await clientEngine.stopServer();
        await hostEngine.stopServer();
      });

      final hostReceived = Completer<Map<String, dynamic>>();
      final clientReceived = Completer<Map<String, dynamic>>();
      final hostClientCounts = <int>[];

      hostEngine.onClientCountChanged = hostClientCounts.add;
      hostEngine.onPacketReceived = (pkt) {
        if (!hostReceived.isCompleted) hostReceived.complete(pkt);
      };
      clientEngine.onPacketReceived = (pkt) {
        if (!clientReceived.isCompleted) clientReceived.complete(pkt);
      };

      final boundPort = await hostEngine.startServer(preferredPort: 0);
      expect(boundPort, greaterThan(0));

      final connected = await clientEngine.connectToPeerWebSocket('127.0.0.1', boundPort);
      expect(connected, isTrue);
      expect(clientEngine.connectedClientsCount, 1);

      // Calling connectToPeerWebSocket again to the same endpoint reuses existing socket
      final connectedAgain = await clientEngine.connectToPeerWebSocket('127.0.0.1', boundPort);
      expect(connectedAgain, isTrue);
      expect(clientEngine.connectedClientsCount, 1);

      // Client -> Host over WebSocket
      clientEngine.broadcastJson({
        'type': 'shopping_item_toggle',
        'itemId': 'item_42',
        'name': 'Pecorino Romano',
      });
      final fromClient = await hostReceived.future.timeout(const Duration(seconds: 3));
      expect(fromClient['type'], 'shopping_item_toggle');
      expect(fromClient['name'], 'Pecorino Romano');
      expect(hostClientCounts, contains(1));

      // Host -> Client over the same WebSocket
      hostEngine.broadcastJson({
        'type': 'cook_step_sync',
        'recipeId': 'rec_carbonara',
        'stepIndex': 3,
        'totalSteps': 5,
      });
      final fromHost = await clientReceived.future.timeout(const Duration(seconds: 3));
      expect(fromHost['type'], 'cook_step_sync');
      expect(fromHost['stepIndex'], 3);
    });

    test('prevents infinite relay echo loops when two phones connect to each other simultaneously', () async {
      final phoneA = LanSyncAndBleCodecEngine();
      final phoneB = LanSyncAndBleCodecEngine();
      addTearDown(() async {
        await phoneA.stopServer();
        await phoneB.stopServer();
      });

      var phoneAReceiveCount = 0;
      var phoneBReceiveCount = 0;
      final phoneBFirstPacket = Completer<Map<String, dynamic>>();

      phoneA.onPacketReceived = (_) {
        phoneAReceiveCount++;
      };
      phoneB.onPacketReceived = (pkt) {
        phoneBReceiveCount++;
        if (!phoneBFirstPacket.isCompleted) phoneBFirstPacket.complete(pkt);
      };

      final portA = await phoneA.startServer(preferredPort: 0);
      final portB = await phoneB.startServer(preferredPort: 0);

      // Both phones connect outbound to each other (2 parallel WebSocket links between A and B)
      expect(await phoneA.connectToPeerWebSocket('127.0.0.1', portB), isTrue);
      expect(await phoneB.connectToPeerWebSocket('127.0.0.1', portA), isTrue);

      phoneA.broadcastJson({
        'type': 'shopping_item_toggle',
        'itemId': 'ing_loop_test',
        'name': 'Guanciale',
        'checked': true,
      });

      final received = await phoneBFirstPacket.future.timeout(const Duration(seconds: 3));
      expect(received['itemId'], 'ing_loop_test');

      // Allow any potential echo/relay frames to settle
      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(phoneBReceiveCount, 1);
      expect(phoneAReceiveCount, 0);
    });

    test('discovers peer over real RawDatagramSocket UDP datagram exchange', () async {
      final listenerNode = LanSyncAndBleCodecEngine();
      final senderNode = LanSyncAndBleCodecEngine();
      addTearDown(() async {
        await listenerNode.stopServer();
        await senderNode.stopServer();
      });

      final discoveredBeacon = Completer<Map<String, dynamic>>();
      listenerNode.onPeerDiscovered = (beacon) {
        if (!discoveredBeacon.isCompleted) discoveredBeacon.complete(beacon);
      };

      final listenerStarted = await listenerNode.startUdpDiscovery(
        localIp: '192.168.1.10',
        lanPort: 8765,
        udpPort: 0,
      );
      expect(listenerStarted, isTrue);
      final targetUdpPort = listenerNode.boundUdpPort!;
      expect(targetUdpPort, greaterThan(0));

      final senderStarted = await senderNode.startUdpDiscovery(
        localIp: '192.168.1.20',
        lanPort: 8766,
        udpPort: 0,
      );
      expect(senderStarted, isTrue);

      final sentBytes = senderNode.sendUdpBeacon(
        localIp: '192.168.1.20',
        lanPort: 8766,
        roomCode: 'MOB-2026',
        deviceName: 'iPhone 16 Pro Max',
        targetAddress: '127.0.0.1',
        targetPort: targetUdpPort,
      );
      expect(sentBytes, greaterThan(0));

      final beacon = await discoveredBeacon.future.timeout(const Duration(seconds: 3));
      expect(beacon['ip'], '192.168.1.20');
      expect(beacon['port'], 8766);
      expect(beacon['device'], 'iPhone 16 Pro Max');
    });

    test('falls back to HTTP POST /sync when no WebSocket is open but peer endpoint is configured', () async {
      final hostEngine = LanSyncAndBleCodecEngine();
      final senderEngine = LanSyncAndBleCodecEngine();
      addTearDown(() async {
        await senderEngine.stopServer();
        await hostEngine.stopServer();
      });

      final hostReceived = Completer<Map<String, dynamic>>();
      hostEngine.onPacketReceived = (pkt) {
        if (!hostReceived.isCompleted) hostReceived.complete(pkt);
      };

      final port = await hostEngine.startServer(preferredPort: 0);
      senderEngine.configurePeerEndpoint('127.0.0.1', port);
      expect(senderEngine.connectedClientsCount, 0);

      // broadcastJson should automatically deliver via HTTP /sync fallback
      senderEngine.broadcastJson({
        'type': 'shopping_item_toggle',
        'name': 'Sızma Zeytinyağı',
      });

      final pkt = await hostReceived.future.timeout(const Duration(seconds: 3));
      expect(pkt['name'], 'Sızma Zeytinyağı');
    });
  });

  group('SmartKitchenHubNotifier State, Packet Types & Native Diagnostics', () {
    test('toggles BLE device connection, applies temp presets, and tares smart scale', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(smartKitchenHubProvider.notifier);
      final initial = container.read(smartKitchenHubProvider);

      expect(initial.devices.length, 4);
      expect(initial.connectedCount, 0);

      // Connect BLE Probe and ESP32 node
      notifier.toggleDeviceConnection('ble_probe_01');
      notifier.toggleDeviceConnection('esp32_kitchen_01');
      expect(container.read(smartKitchenHubProvider).connectedCount, 2);

      // Apply Medium-Rare Steak 56°C preset & heat burst
      notifier.applyTempPreset(CulinaryTempPreset.mediumRareSteak);
      expect(container.read(smartKitchenHubProvider).probeTargetTempC, 56.0);

      final beforeTemp = container.read(smartKitchenHubProvider).probeCurrentTempC;
      notifier.simulateHeatBurst(deltaC: 6.0);
      expect(
        container.read(smartKitchenHubProvider).probeCurrentTempC,
        closeTo(beforeTemp + 6.0, 0.01),
      );

      // Smart Scale pour & tare
      notifier.pourIngredientOnScale(100.0);
      expect(container.read(smartKitchenHubProvider).scaleNetWeightG, closeTo(100.0, 0.1));

      notifier.tareScale();
      expect(container.read(smartKitchenHubProvider).scaleNetWeightG, closeTo(0.0, 0.1));

      notifier.pourIngredientOnScale(50.0);
      expect(container.read(smartKitchenHubProvider).scaleNetWeightG, closeTo(50.0, 0.1));
    });

    test('handles shopping_item_toggle, cook_step_sync, UDP MANET beacon discovery, and Native Network MethodChannel', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SmartKitchenHubNotifier.nativeNetworkChannel, (call) async {
        if (call.method == 'getNativeNetworkDiagnostics') {
          return <String, dynamic>{
            'platform': 'Android 15 (API 35)',
            'transport': 'WIFI',
            'isConnected': true,
            'rssiDbm': -48,
            'linkSpeedMbps': 866,
            'frequencyMhz': 5240,
            'ipv4Address': '192.168.1.88',
            'bluetoothState': 'ON',
          };
        }
        return null;
      });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SmartKitchenHubNotifier.nativeNetworkChannel, null);
      });

      final fakeShoppingRepo = _FakeShoppingRepository();
      final container = ProviderContainer(
        overrides: [
          shoppingRepositoryProvider.overrideWithValue(fakeShoppingRepo),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(smartKitchenHubProvider.notifier);

      // 1. Native Network Diagnostics via MethodChannel
      final diag = await notifier.refreshNativeNetworkDiagnostics();
      expect(diag.isFromNativeChannel, isTrue);
      expect(diag.platform, contains('Android 15'));
      expect(diag.rssiDbm, -48);
      expect(diag.linkSpeedMbps, 866);
      expect(diag.frequencyBandLabel, '5 GHz');
      expect(container.read(smartKitchenHubProvider).localIpAddress, '192.168.1.88');

      // 2. Incoming shopping_item_toggle packet without checked boolean -> calls toggleItemChecked
      await notifier.processIncomingPacket({
        'type': 'shopping_item_toggle',
        'sender': 'iPhone 16 Pro',
        'itemId': 'ing_1',
        'name': 'Taze Fesleğen',
      });
      expect(fakeShoppingRepo.lastToggledItemId, 'ing_1');
      expect(
        container.read(smartKitchenHubProvider).syncEvents.first.description,
        contains('Taze Fesleğen'),
      );

      // 2b. Incoming shopping_toggle with explicit checked boolean inside nested payload map -> calls setItemChecked
      await notifier.processIncomingPacket({
        'type': 'shopping_toggle',
        'sender': 'iPhone 16 Pro',
        'payload': {
          'item_id': 'ing_2',
          'item_name': 'Sarımsak',
          'checked': true,
        },
      });
      expect(fakeShoppingRepo.lastSetItemId, 'ing_2');
      expect(fakeShoppingRepo.lastSetCheckedValue, isTrue);

      // 3. Incoming cook_step_sync packet (CookModeScreen format)
      await notifier.processIncomingPacket({
        'type': 'cook_step_sync',
        'sender': 'iPhone 16 Pro',
        'recipeId': 'spicy_vodka_rigatoni',
        'stepIndex': 2,
        'totalSteps': 4,
      });
      final afterCookState = container.read(smartKitchenHubProvider);
      expect(afterCookState.lastSyncedCookStep, 'spicy_vodka_rigatoni:2/4');
      expect(afterCookState.syncEvents.first.type, 'cook_step_sync');

      // 4. Zero-config UDP Broadcast MANET beacon discovery (deduplicated across periodic beacons)
      final beacon = <String, dynamic>{
        'type': 'mob_beacon',
        'ip': '192.168.1.92',
        'port': 8765,
        'room': 'MOB-2026',
        'device': 'Sous-Chef Galaxy S25',
      };
      await notifier.handleUdpBeaconDiscovered(beacon);
      final afterFirstUdp = container.read(smartKitchenHubProvider);
      expect(afterFirstUdp.discoveredPeers, ['192.168.1.92:8765']);
      expect(afterFirstUdp.connectedPeerCount, 1);
      final eventCountAfterFirst = afterFirstUdp.syncEvents.length;

      // Second identical periodic beacon does not duplicate peer or spam syncEvents
      await notifier.handleUdpBeaconDiscovered(beacon);
      final afterSecondUdp = container.read(smartKitchenHubProvider);
      expect(afterSecondUdp.discoveredPeers, ['192.168.1.92:8765']);
      expect(afterSecondUdp.syncEvents.length, eventCountAfterFirst);
    });

    test('starts and stops real dart:io HTTP/WebSocket LAN Co-Op Server and manages Android MulticastLock', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final multicastCalls = <bool>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SmartKitchenHubNotifier.nativeNetworkChannel, (call) async {
        if (call.method == 'getNativeNetworkDiagnostics') {
          return <String, dynamic>{
            'platform': 'Android 15 (API 35)',
            'transport': 'WIFI',
            'isConnected': true,
            'rssiDbm': -50,
            'linkSpeedMbps': 866,
            'frequencyMhz': 5180,
            'ipv4Address': '192.168.1.88',
            'bluetoothState': 'ON',
            'multicastLockHeld': true,
          };
        }
        if (call.method == 'setMulticastLock') {
          final args = call.arguments as Map<dynamic, dynamic>?;
          multicastCalls.add(args?['enabled'] as bool? ?? false);
          return true;
        }
        return null;
      });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SmartKitchenHubNotifier.nativeNetworkChannel, null);
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(smartKitchenHubProvider.notifier);
      await notifier.refreshNativeNetworkDiagnostics();

      await notifier.toggleLanCoOpServer();
      final runningState = container.read(smartKitchenHubProvider);
      expect(runningState.isLanServerRunning, isTrue);
      expect(runningState.localIpAddress, '192.168.1.88');
      expect(multicastCalls, contains(true));

      notifier.broadcastCoOpEvent(
        'shopping_item_toggle',
        'Test paketi: Guanciale sepete eklendi',
      );
      expect(
        container.read(smartKitchenHubProvider).syncEvents.first.summary,
        contains('Guanciale'),
      );

      await notifier.simulatePeerCookStepSync();
      expect(
        container.read(smartKitchenHubProvider).lastSyncedCookStep,
        'spicy_vodka_rigatoni:1/4',
      );
      await notifier.simulatePeerCookStepSync();
      expect(
        container.read(smartKitchenHubProvider).lastSyncedCookStep,
        'spicy_vodka_rigatoni:2/4',
      );

      await notifier.toggleLanCoOpServer();
      expect(container.read(smartKitchenHubProvider).isLanServerRunning, isFalse);
      expect(multicastCalls.last, isFalse);
    });
  });

  group('SmartKitchenHubScreen Widget Tests', () {
    testWidgets('renders Radar, Native Diagnostics, Telemetry, and Wi-Fi Co-Op tabs and interacts cleanly', (
      tester,
    ) async {
      final fakeShoppingRepo = _FakeShoppingRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            shoppingRepositoryProvider.overrideWithValue(fakeShoppingRepo),
          ],
          child: const MaterialApp(
            home: SmartKitchenHubScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Radar tab shows BLE & Wi-Fi devices and Native OS Network Diagnostics card
      expect(find.text('Smart Kitchen BLE & Wireless Hub'), findsOneWidget);
      expect(find.textContaining('MobProbe Pro'), findsOneWidget);
      expect(
        find.textContaining('Native OS Network & Radio Diagnostics'),
        findsOneWidget,
      );

      // Switch to Live Telemetry tab
      await tester.tap(find.text('Canlı Telemetri'));
      await tester.pumpAndSettle();

      expect(find.text('Isıyı Artır (+7.5°C)'), findsOneWidget);
      await tester.tap(find.text('Isıyı Artır (+7.5°C)'));
      await tester.pumpAndSettle();

      // Switch to Wi-Fi Co-Op tab
      await tester.tap(find.text('Wi-Fi Co-Op'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Wi-Fi LAN Co-Op Sunucusu'), findsOneWidget);
      expect(find.textContaining('UDP Broadcast MANET'), findsOneWidget);
      final simBtn = find.text('Eş Telefondan Canlı Market İşaretlemesi Simüle Et');
      await tester.ensureVisible(simBtn);
      await tester.pumpAndSettle();
      await tester.tap(simBtn);
      await tester.pumpAndSettle();

      expect(find.textContaining('Sarımsak'), findsOneWidget);

      final cookSimBtn = find.text(
        'Simulate Peer Cook Mode Step Sync (Co-Op Adım Senkronu)',
      );
      await tester.ensureVisible(cookSimBtn);
      await tester.pumpAndSettle();
      await tester.tap(cookSimBtn);
      await tester.pumpAndSettle();

      expect(find.textContaining('spicy_vodka_rigatoni:1/4'), findsOneWidget);
    });
  });
}
