import 'package:equatable/equatable.dart';

enum KitchenDeviceType {
  meatThermometer(
    'meat_thermometer',
    'BLE Smart Meat & Pan Thermometer',
    'GATT 0x181A · Core & Ambient Thermal Sensor',
  ),
  smartScale(
    'smart_scale',
    'BLE Precision Kitchen Scale',
    'GATT 0x181D · 0.1g Precision Load Cell',
  ),
  esp32SensorNode(
    'esp32_node',
    'ESP32 Smart Kitchen IoT Node',
    'Dual-Mode: BLE 5.0 + Wi-Fi WebSocket Telemetry',
  ),
  peerPhone(
    'peer_phone',
    'Co-Op Companion Device (iOS / Android)',
    'Wi-Fi LAN P2P · Real-time Grocery & Cook Sync',
  );

  const KitchenDeviceType(this.id, this.title, this.specSubtitle);
  final String id;
  final String title;
  final String specSubtitle;
}

enum WirelessProtocol {
  bleGatt('BLE 5.0 GATT'),
  wifiLan('Wi-Fi LAN / WS');

  const WirelessProtocol(this.badge);
  final String badge;
}

enum CulinaryTempPreset {
  mediumRareSteak('Medium Rare Steak', 56.0, 210.0),
  mediumSteak('Medium Steak', 62.0, 210.0),
  juicyChicken('Juicy Chicken Breast / Thigh', 74.0, 185.0),
  crispySkinSalmon('Crispy Skin Salmon', 58.0, 175.0),
  deepFryOil('Deep Frying Oil', 180.0, 220.0);

  const CulinaryTempPreset(this.label, this.targetTempC, this.recommendedPanTempC);
  final String label;
  final double targetTempC;
  final double recommendedPanTempC;
}

class SmartKitchenDevice extends Equatable {
  const SmartKitchenDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.protocol,
    required this.rssiDbm,
    required this.batteryPercent,
    this.macOrIpAddress = '',
    this.isConnected = false,
    this.isSimulated = true,
  });

  final String id;
  final String name;
  final KitchenDeviceType type;
  final WirelessProtocol protocol;
  final int rssiDbm;
  final int batteryPercent;
  final String macOrIpAddress;
  final bool isConnected;
  final bool isSimulated;

  /// Sinyal kalitesi yüzdesi (-100 dBm = %0, -40 dBm = %100).
  int get signalQualityPercent => ((rssiDbm + 100) * 100 ~/ 60).clamp(5, 100);

  SmartKitchenDevice copyWith({
    int? rssiDbm,
    int? batteryPercent,
    String? macOrIpAddress,
    bool? isConnected,
    bool? isSimulated,
  }) {
    return SmartKitchenDevice(
      id: id,
      name: name,
      type: type,
      protocol: protocol,
      rssiDbm: rssiDbm ?? this.rssiDbm,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      macOrIpAddress: macOrIpAddress ?? this.macOrIpAddress,
      isConnected: isConnected ?? this.isConnected,
      isSimulated: isSimulated ?? this.isSimulated,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        protocol,
        rssiDbm,
        batteryPercent,
        macOrIpAddress,
        isConnected,
        isSimulated,
      ];
}

class ThermometerTelemetry extends Equatable {
  const ThermometerTelemetry({
    this.currentTempC = 24.5,
    this.targetTempC = 74.0,
    this.ambientTempC = 185.0,
    this.rateCPerMinute = 8.4,
    this.history = const [24.0, 24.5],
  });

  final double currentTempC;
  final double targetTempC;
  final double ambientTempC;
  final double rateCPerMinute;
  final List<double> history;

  bool get isTargetReached => currentTempC >= targetTempC;

  double get progress =>
      targetTempC > 20 ? ((currentTempC - 20) / (targetTempC - 20)).clamp(0.0, 1.0) : 0.0;

  int get estimatedSecondsRemaining {
    if (isTargetReached || rateCPerMinute <= 0.1) return 0;
    final remainingC = targetTempC - currentTempC;
    return ((remainingC / rateCPerMinute) * 60).round().clamp(0, 7200);
  }

  ThermometerTelemetry copyWith({
    double? currentTempC,
    double? targetTempC,
    double? ambientTempC,
    double? rateCPerMinute,
    List<double>? history,
  }) {
    return ThermometerTelemetry(
      currentTempC: currentTempC ?? this.currentTempC,
      targetTempC: targetTempC ?? this.targetTempC,
      ambientTempC: ambientTempC ?? this.ambientTempC,
      rateCPerMinute: rateCPerMinute ?? this.rateCPerMinute,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [
        currentTempC,
        targetTempC,
        ambientTempC,
        rateCPerMinute,
        history,
      ];
}

class SmartScaleTelemetry extends Equatable {
  const SmartScaleTelemetry({
    this.rawWeightGrams = 0.0,
    this.tareOffsetGrams = 0.0,
    this.targetWeightGrams = 400.0,
    this.targetIngredientName = 'Chicken / Pasta',
    this.isStable = true,
  });

  final double rawWeightGrams;
  final double tareOffsetGrams;
  final double targetWeightGrams;
  final String targetIngredientName;
  final bool isStable;

  double get netWeightGrams => (rawWeightGrams - tareOffsetGrams).clamp(0.0, 10000.0);

  double get progress =>
      targetWeightGrams > 0 ? (netWeightGrams / targetWeightGrams).clamp(0.0, 1.2) : 0.0;

  bool get isAtTarget =>
      targetWeightGrams > 0 && (netWeightGrams - targetWeightGrams).abs() <= 5.0;

  SmartScaleTelemetry copyWith({
    double? rawWeightGrams,
    double? tareOffsetGrams,
    double? targetWeightGrams,
    String? targetIngredientName,
    bool? isStable,
  }) {
    return SmartScaleTelemetry(
      rawWeightGrams: rawWeightGrams ?? this.rawWeightGrams,
      tareOffsetGrams: tareOffsetGrams ?? this.tareOffsetGrams,
      targetWeightGrams: targetWeightGrams ?? this.targetWeightGrams,
      targetIngredientName: targetIngredientName ?? this.targetIngredientName,
      isStable: isStable ?? this.isStable,
    );
  }

  @override
  List<Object?> get props => [
        rawWeightGrams,
        tareOffsetGrams,
        targetWeightGrams,
        targetIngredientName,
        isStable,
      ];
}

class WirelessSyncEvent extends Equatable {
  const WirelessSyncEvent({
    required this.id,
    required this.type,
    required this.senderDevice,
    required this.description,
    required this.timestamp,
  });

  final String id;
  final String type;
  final String senderDevice;
  final String description;
  final DateTime timestamp;

  String get summary => description;

  @override
  List<Object?> get props => [id, type, senderDevice, description, timestamp];
}

class NativeNetworkDiagnostics extends Equatable {
  const NativeNetworkDiagnostics({
    this.platform = 'Android ConnectivityManager / iOS NWPathMonitor',
    this.transport = 'WIFI',
    this.isConnected = true,
    this.rssiDbm = -53,
    this.linkSpeedMbps = 433,
    this.frequencyMhz = 5180,
    this.ipv4Address = '192.168.1.42',
    this.bluetoothState = 'ON',
    this.isFromNativeChannel = false,
  });

  final String platform;
  final String transport;
  final bool isConnected;
  final int rssiDbm;
  final int linkSpeedMbps;
  final int frequencyMhz;
  final String ipv4Address;
  final String bluetoothState;
  final bool isFromNativeChannel;

  String get frequencyBandLabel => frequencyMhz >= 4900 ? '5 GHz' : '2.4 GHz';

  factory NativeNetworkDiagnostics.fromMap(
    Map<dynamic, dynamic> map, {
    bool isFromNativeChannel = true,
  }) {
    return NativeNetworkDiagnostics(
      platform: map['platform']?.toString() ?? 'Android / iOS Native',
      transport: map['transport']?.toString() ?? 'WIFI',
      isConnected: map['isConnected'] as bool? ?? true,
      rssiDbm: (map['rssiDbm'] as num?)?.toInt() ?? -53,
      linkSpeedMbps: (map['linkSpeedMbps'] as num?)?.toInt() ?? 433,
      frequencyMhz: (map['frequencyMhz'] as num?)?.toInt() ?? 5180,
      ipv4Address: map['ipv4Address']?.toString() ?? '192.168.1.42',
      bluetoothState: map['bluetoothState']?.toString() ?? 'ON',
      isFromNativeChannel: isFromNativeChannel,
    );
  }

  NativeNetworkDiagnostics copyWith({
    String? platform,
    String? transport,
    bool? isConnected,
    int? rssiDbm,
    int? linkSpeedMbps,
    int? frequencyMhz,
    String? ipv4Address,
    String? bluetoothState,
    bool? isFromNativeChannel,
  }) {
    return NativeNetworkDiagnostics(
      platform: platform ?? this.platform,
      transport: transport ?? this.transport,
      isConnected: isConnected ?? this.isConnected,
      rssiDbm: rssiDbm ?? this.rssiDbm,
      linkSpeedMbps: linkSpeedMbps ?? this.linkSpeedMbps,
      frequencyMhz: frequencyMhz ?? this.frequencyMhz,
      ipv4Address: ipv4Address ?? this.ipv4Address,
      bluetoothState: bluetoothState ?? this.bluetoothState,
      isFromNativeChannel: isFromNativeChannel ?? this.isFromNativeChannel,
    );
  }

  @override
  List<Object?> get props => [
        platform,
        transport,
        isConnected,
        rssiDbm,
        linkSpeedMbps,
        frequencyMhz,
        ipv4Address,
        bluetoothState,
        isFromNativeChannel,
      ];
}

class SmartKitchenHubState extends Equatable {
  const SmartKitchenHubState({
    this.isScanning = false,
    this.simulationModeEnabled = true,
    this.devices = const [],
    this.thermometer = const ThermometerTelemetry(),
    this.scale = const SmartScaleTelemetry(),
    this.isLanHostRunning = false,
    this.isUdpDiscoveryActive = false,
    this.localIpAddress = '192.168.1.42',
    this.lanPort = 8765,
    this.roomCode = 'SIMMER-2026',
    this.connectedPeerCount = 0,
    this.discoveredPeers = const [],
    this.nativeDiagnostics = const NativeNetworkDiagnostics(),
    this.lastSyncedCookStep,
    this.syncEvents = const [],
  });

  final bool isScanning;
  final bool simulationModeEnabled;
  final List<SmartKitchenDevice> devices;
  final ThermometerTelemetry thermometer;
  final SmartScaleTelemetry scale;
  final bool isLanHostRunning;
  final bool isUdpDiscoveryActive;
  final String localIpAddress;
  final int lanPort;
  final String roomCode;
  final int connectedPeerCount;
  final List<String> discoveredPeers;
  final NativeNetworkDiagnostics nativeDiagnostics;
  final String? lastSyncedCookStep;
  final List<WirelessSyncEvent> syncEvents;

  bool get hasConnectedThermometer => devices.any(
        (d) =>
            d.isConnected &&
            (d.type == KitchenDeviceType.meatThermometer ||
                d.type == KitchenDeviceType.esp32SensorNode),
      );

  bool get hasConnectedScale => devices.any(
        (d) =>
            d.isConnected &&
            (d.type == KitchenDeviceType.smartScale ||
                d.type == KitchenDeviceType.esp32SensorNode),
      );

  int get connectedDevicesCount => devices.where((d) => d.isConnected).length;
  int get connectedCount => connectedDevicesCount;
  double get probeCurrentTempC => thermometer.currentTempC;
  double get probeTargetTempC => thermometer.targetTempC;
  bool get isTargetTempReached => thermometer.isTargetReached;
  double get scaleNetWeightG => scale.netWeightGrams;
  bool get isLanServerRunning => isLanHostRunning;

  SmartKitchenHubState copyWith({
    bool? isScanning,
    bool? simulationModeEnabled,
    List<SmartKitchenDevice>? devices,
    ThermometerTelemetry? thermometer,
    SmartScaleTelemetry? scale,
    bool? isLanHostRunning,
    bool? isUdpDiscoveryActive,
    String? localIpAddress,
    int? lanPort,
    String? roomCode,
    int? connectedPeerCount,
    List<String>? discoveredPeers,
    NativeNetworkDiagnostics? nativeDiagnostics,
    String? lastSyncedCookStep,
    List<WirelessSyncEvent>? syncEvents,
  }) {
    return SmartKitchenHubState(
      isScanning: isScanning ?? this.isScanning,
      simulationModeEnabled: simulationModeEnabled ?? this.simulationModeEnabled,
      devices: devices ?? this.devices,
      thermometer: thermometer ?? this.thermometer,
      scale: scale ?? this.scale,
      isLanHostRunning: isLanHostRunning ?? this.isLanHostRunning,
      isUdpDiscoveryActive: isUdpDiscoveryActive ?? this.isUdpDiscoveryActive,
      localIpAddress: localIpAddress ?? this.localIpAddress,
      lanPort: lanPort ?? this.lanPort,
      roomCode: roomCode ?? this.roomCode,
      connectedPeerCount: connectedPeerCount ?? this.connectedPeerCount,
      discoveredPeers: discoveredPeers ?? this.discoveredPeers,
      nativeDiagnostics: nativeDiagnostics ?? this.nativeDiagnostics,
      lastSyncedCookStep: lastSyncedCookStep ?? this.lastSyncedCookStep,
      syncEvents: syncEvents ?? this.syncEvents,
    );
  }

  @override
  List<Object?> get props => [
        isScanning,
        simulationModeEnabled,
        devices,
        thermometer,
        scale,
        isLanHostRunning,
        isUdpDiscoveryActive,
        localIpAddress,
        lanPort,
        roomCode,
        connectedPeerCount,
        discoveredPeers,
        nativeDiagnostics,
        lastSyncedCookStep,
        syncEvents,
      ];
}
