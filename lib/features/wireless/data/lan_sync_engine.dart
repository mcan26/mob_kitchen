import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// BLE GATT (0x181A Environmental Sensing & 0x181D Weight Scale) ikili (binary)
/// paket çözücüleri ve yerel Wi-Fi (HTTP + WebSocket) P2P senkronizasyon motoru.
class LanSyncAndBleCodecEngine {
  static const int defaultUdpDiscoveryPort = 41234;

  HttpServer? _httpServer;
  RawDatagramSocket? _udpSocket;
  Timer? _udpBeaconTimer;
  final Set<WebSocket> _connectedSockets = {};
  final Map<String, WebSocket> _outboundSocketsByEndpoint = {};
  final Set<String> _seenPacketIds = {};
  int _packetSequence = 0;
  String? _configuredPeerIp;
  int? _configuredPeerPort;

  void Function(Map<String, dynamic> packet)? onPacketReceived;
  void Function(int clientCount)? onClientCountChanged;
  void Function(Map<String, dynamic> beacon)? onPeerDiscovered;

  bool get isRunning => _httpServer != null;
  int? get boundPort => _httpServer?.port;
  bool get isUdpDiscoveryRunning => _udpSocket != null;
  int? get boundUdpPort => _udpSocket?.port;
  int get connectedClientsCount => _connectedSockets.length;
  String? get configuredPeerIp => _configuredPeerIp;
  int? get configuredPeerPort => _configuredPeerPort;

  String _ensurePacketId(Map<String, dynamic> packet) {
    final existing = packet['_pkt_id']?.toString();
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final generated = 'pkt_${DateTime.now().microsecondsSinceEpoch}_${++_packetSequence}';
    packet['_pkt_id'] = generated;
    return generated;
  }

  /// Paketin daha önce bu düğüm tarafından üretilip üretilmediğini veya işlenip işlenmediğini
  /// kontrol eder. İlk kez görülüyorsa `true`, tekrar (echo/loop) ise `false` döner.
  bool _markPacketSeen(Map<String, dynamic> packet) {
    final id = packet['_pkt_id']?.toString();
    if (id == null || id.isEmpty) return true;
    if (_seenPacketIds.contains(id)) return false;
    if (_seenPacketIds.length >= 256) {
      _seenPacketIds.remove(_seenPacketIds.first);
    }
    _seenPacketIds.add(id);
    return true;
  }

  /// BLE GATT 0x2A6E (Temperature Measurement) 16-bit signed little-endian
  /// bayt dizisini (0.01 °C çözünürlük) derece Celsius'a dönüştürür.
  /// Örn: `[0xD0, 0x1C]` -> `7376 * 0.01 = 73.76 °C`.
  static double decodeBleTemperatureBytes(List<int> bytes) {
    if (bytes.length < 2) {
      throw const FormatException('BLE sıcaklık paketi en az 2 bayt olmalıdır.');
    }
    final data = ByteData.sublistView(Uint8List.fromList(bytes));
    final rawHundredths = data.getInt16(0, Endian.little);
    return rawHundredths / 100.0;
  }

  /// Derece Celsius değerini BLE GATT 0x2A6E uyumlu 2 baytlık little-endian diziye kodlar.
  static Uint8List encodeBleTemperatureBytes(double tempC) {
    final data = ByteData(2);
    data.setInt16(0, (tempC * 100).round(), Endian.little);
    return data.buffer.asUint8List();
  }

  /// BLE GATT 0x2A9D (Weight Measurement) bayt dizisini (bayrak + uint16 0.1g birim)
  /// gram değerine dönüştürür.
  static double decodeBleScaleWeightBytes(List<int> bytes) {
    if (bytes.length < 3) {
      throw const FormatException('BLE tartı paketi en az 3 bayt (flags + uint16) olmalıdır.');
    }
    final data = ByteData.sublistView(Uint8List.fromList(bytes));
    final rawDecigrams = data.getUint16(1, Endian.little);
    return rawDecigrams / 10.0;
  }

  /// Gram değerini BLE GATT 0x2A9D uyumlu 3 baytlık (flags + uint16 0.1g) diziye kodlar.
  static Uint8List encodeBleScaleWeightBytes(double weightGrams) {
    final data = ByteData(3);
    data.setUint8(0, 0x00); // SI units flag
    data.setUint16(1, (weightGrams * 10).round().clamp(0, 65535), Endian.little);
    return data.buffer.asUint8List();
  }

  /// UDP Broadcast (Port 41234) MANET sıfır-konfigürasyonlu düğüm keşif paketi oluşturur.
  static Map<String, dynamic> buildUdpBeaconPayload({
    required String ip,
    required int port,
    required String room,
    required String device,
  }) {
    return <String, dynamic>{
      'type': 'mob_beacon',
      'ip': ip,
      'port': port,
      'room': room,
      'device': device,
    };
  }

  /// UDP Broadcast keşif paketini UTF-8 bayt dizisine kodlar.
  static Uint8List encodeUdpBeaconBytes({
    required String ip,
    required int port,
    required String room,
    required String device,
  }) {
    final payload = buildUdpBeaconPayload(
      ip: ip,
      port: port,
      room: room,
      device: device,
    );
    return Uint8List.fromList(utf8.encode(jsonEncode(payload)));
  }

  /// Gelen UDP datagram baytlarını doğrular ve `mob_beacon` ise çözümler.
  static Map<String, dynamic>? tryDecodeUdpBeaconBytes(List<int> bytes) {
    try {
      final raw = utf8.decode(bytes, allowMalformed: true).trim();
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic> && decoded['type'] == 'mob_beacon') {
        return decoded;
      }
    } catch (_) {}
    return null;
  }

  /// Cihazın yerel Wi-Fi IPv4 adresini tespit eder (örn. `192.168.1.x`).
  static Future<String> resolveLocalIpv4() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );
      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          if (!addr.isLoopback &&
              (addr.address.startsWith('192.168.') ||
                  addr.address.startsWith('10.') ||
                  addr.address.startsWith('172.'))) {
            return addr.address;
          }
        }
      }
      if (interfaces.isNotEmpty && interfaces.first.addresses.isNotEmpty) {
        return interfaces.first.addresses.first.address;
      }
    } catch (_) {
      // Sandbox veya izin kısıtlı test ortamı için güvenli fallback
    }
    return '192.168.1.42';
  }

  /// Hedef eş (peer) telefonun IP ve port bilgisini HTTP fallback için kaydeder.
  void configurePeerEndpoint(String hostIp, [int port = 8765]) {
    _configuredPeerIp = hostIp.trim();
    _configuredPeerPort = port;
  }

  void _removeSocket(WebSocket socket, [String? endpointKey]) {
    final removed = _connectedSockets.remove(socket);
    if (endpointKey != null && _outboundSocketsByEndpoint[endpointKey] == socket) {
      _outboundSocketsByEndpoint.remove(endpointKey);
    } else {
      _outboundSocketsByEndpoint.removeWhere((_, s) => s == socket);
    }
    if (removed) {
      onClientCountChanged?.call(_connectedSockets.length);
    }
  }

  void _registerWebSocket(WebSocket socket, {String? endpointKey}) {
    _connectedSockets.add(socket);
    if (endpointKey != null) {
      _outboundSocketsByEndpoint[endpointKey] = socket;
    }
    onClientCountChanged?.call(_connectedSockets.length);
    socket.listen(
      (data) {
        try {
          final decoded = jsonDecode(data.toString()) as Map<String, dynamic>;
          _ensurePacketId(decoded);
          if (!_markPacketSeen(decoded)) {
            return;
          }
          onPacketReceived?.call(decoded);
          // Diğer bağlı telefonlara da ilet (relay)
          for (final peer in _connectedSockets.toList()) {
            if (peer != socket) {
              try {
                peer.add(jsonEncode(decoded));
              } catch (_) {
                _removeSocket(peer);
              }
            }
          }
        } catch (_) {}
      },
      onDone: () => _removeSocket(socket, endpointKey),
      onError: (_) => _removeSocket(socket, endpointKey),
    );
  }

  /// İki telefon arasında çift yönlü (full-duplex) gerçek zamanlı `/ws` WebSocket
  /// istemci bağlantısı kurar. Aynı hedefe açık bir bağlantı varsa yeniden kullanır.
  Future<bool> connectToPeerWebSocket(String hostIp, [int port = 8765]) async {
    final normalizedHost = hostIp.trim();
    final endpointKey = '$normalizedHost:$port';
    configurePeerEndpoint(normalizedHost, port);

    final existing = _outboundSocketsByEndpoint[endpointKey];
    if (existing != null &&
        _connectedSockets.contains(existing) &&
        existing.readyState == WebSocket.open) {
      return true;
    }

    try {
      final wsUrl = 'ws://$normalizedHost:$port/ws';
      final socket = await WebSocket.connect(wsUrl).timeout(
        const Duration(seconds: 3),
      );
      _registerWebSocket(socket, endpointKey: endpointKey);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Android, iOS veya ESP32 düğümlerinin bağlanabileceği gerçek yerel HTTP + WebSocket sunucusunu başlatır.
  Future<int> startServer({int preferredPort = 8765}) async {
    if (_httpServer != null) return _httpServer!.port;

    try {
      _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, preferredPort, shared: true);
    } catch (_) {
      // Tercih edilen port doluysa işletim sisteminden uygun bir port al
      _httpServer = await HttpServer.bind(InternetAddress.anyIPv4, 0, shared: true);
    }

    _httpServer!.listen(_handleHttpRequest, onError: (_) {});
    return _httpServer!.port;
  }

  /// UDP Broadcast (`RawDatagramSocket` Port 41234) tabanlı sıfır-konfigürasyonlu
  /// MANET eş cihaz keşfini (periyodik yayın + dinleyici) başlatır.
  Future<bool> startUdpDiscovery({
    required String localIp,
    required int lanPort,
    String roomCode = 'MOB-2026',
    String deviceName = 'Mob Kitchen Node',
    int udpPort = defaultUdpDiscoveryPort,
  }) async {
    stopUdpDiscovery();
    try {
      if (udpPort > 0) {
        try {
          _udpSocket = await RawDatagramSocket.bind(
            InternetAddress.anyIPv4,
            udpPort,
            reuseAddress: true,
            reusePort: true,
          );
        } catch (_) {
          try {
            _udpSocket = await RawDatagramSocket.bind(
              InternetAddress.anyIPv4,
              udpPort,
              reuseAddress: true,
            );
          } catch (_) {
            _udpSocket = await RawDatagramSocket.bind(
              InternetAddress.anyIPv4,
              0,
              reuseAddress: true,
            );
          }
        }
      } else {
        _udpSocket = await RawDatagramSocket.bind(
          InternetAddress.anyIPv4,
          0,
          reuseAddress: true,
        );
      }

      try {
        _udpSocket!.broadcastEnabled = true;
      } catch (_) {}

      final broadcastTargetPort =
          udpPort > 0 ? udpPort : (_udpSocket!.port > 0 ? _udpSocket!.port : defaultUdpDiscoveryPort);

      _udpSocket!.listen(
        (RawSocketEvent event) {
          if (event == RawSocketEvent.read) {
            while (true) {
              final dg = _udpSocket?.receive();
              if (dg == null) break;
              final beacon = tryDecodeUdpBeaconBytes(dg.data);
              if (beacon != null) {
                final senderIp = beacon['ip']?.toString();
                final senderPort = (beacon['port'] as num?)?.toInt();
                final isSelf = senderIp == localIp && senderPort == lanPort;
                if (!isSelf) {
                  onPeerDiscovered?.call(beacon);
                }
              }
            }
          }
        },
        onError: (_) {},
        cancelOnError: false,
      );

      sendUdpBeacon(
        localIp: localIp,
        lanPort: lanPort,
        roomCode: roomCode,
        deviceName: deviceName,
        targetPort: broadcastTargetPort,
      );

      _udpBeaconTimer = Timer.periodic(const Duration(seconds: 4), (_) {
        sendUdpBeacon(
          localIp: localIp,
          lanPort: lanPort,
          roomCode: roomCode,
          deviceName: deviceName,
          targetPort: broadcastTargetPort,
        );
      });
      return true;
    } catch (_) {
      stopUdpDiscovery();
      return false;
    }
  }

  /// Verilen IPv4 adresinden `/24` yönlendirilmiş alt ağ yayın (directed broadcast)
  /// adresini hesaplar (örn. `192.168.1.42` -> `192.168.1.255`).
  static String? computeSubnetBroadcastAddress(String ipv4) {
    final parts = ipv4.trim().split('.');
    if (parts.length != 4) return null;
    final octets = <int>[];
    for (final p in parts) {
      final v = int.tryParse(p);
      if (v == null || v < 0 || v > 255) return null;
      octets.add(v);
    }
    if (octets[0] == 127 || octets[0] == 0 || octets[0] >= 224) return null;
    return '${octets[0]}.${octets[1]}.${octets[2]}.255';
  }

  /// Yerel ağa (`255.255.255.255:41234` + `/24` yönlendirilmiş alt ağ yayın adresine
  /// veya belirtilen hedefe) tekil UDP MANET keşif datagramı yayınlar.
  int sendUdpBeacon({
    required String localIp,
    required int lanPort,
    String roomCode = 'MOB-2026',
    String deviceName = 'Mob Kitchen Node',
    String targetAddress = '255.255.255.255',
    int? targetPort,
  }) {
    final socket = _udpSocket;
    if (socket == null) return 0;
    final effectivePort =
        (targetPort != null && targetPort > 0) ? targetPort : defaultUdpDiscoveryPort;
    final bytes = encodeUdpBeaconBytes(
      ip: localIp,
      port: lanPort,
      room: roomCode,
      device: deviceName,
    );

    var maxBytesSent = 0;
    final targets = <String>{targetAddress};
    if (targetAddress == '255.255.255.255') {
      final subnetBroadcast = computeSubnetBroadcastAddress(localIp);
      if (subnetBroadcast != null) {
        targets.add(subnetBroadcast);
      }
    }

    for (final addr in targets) {
      try {
        final sent = socket.send(
          bytes,
          InternetAddress(addr),
          effectivePort,
        );
        if (sent > maxBytesSent) {
          maxBytesSent = sent;
        }
      } catch (_) {}
    }
    return maxBytesSent;
  }

  void stopUdpDiscovery() {
    _udpBeaconTimer?.cancel();
    _udpBeaconTimer = null;
    try {
      _udpSocket?.close();
    } catch (_) {}
    _udpSocket = null;
  }

  Future<void> _handleHttpRequest(HttpRequest request) async {
    request.response.headers.set('Access-Control-Allow-Origin', '*');
    request.response.headers.set('Content-Type', 'application/json; charset=utf-8');

    final path = request.uri.path;

    // 1. WebSocket P2P yükseltmesi (/ws)
    if (path == '/ws' && WebSocketTransformer.isUpgradeRequest(request)) {
      final socket = await WebSocketTransformer.upgrade(request);
      _registerWebSocket(socket);
      return;
    }

    // 2. ESP32 / Uzak Cihaz HTTP POST (/telemetry veya /sync)
    if (request.method == 'POST' && (path == '/telemetry' || path == '/sync')) {
      try {
        final body = await utf8.decoder.bind(request).join();
        final decoded = jsonDecode(body) as Map<String, dynamic>;
        _ensurePacketId(decoded);
        if (_markPacketSeen(decoded)) {
          onPacketReceived?.call(decoded);
          _broadcastToWebSocketsOnly(decoded);
        }
        request.response
          ..statusCode = HttpStatus.ok
          ..write(jsonEncode({'status': 'ok', 'received': true}));
      } catch (e) {
        request.response
          ..statusCode = HttpStatus.badRequest
          ..write(jsonEncode({'status': 'error', 'message': '$e'}));
      } finally {
        await request.response.close();
      }
      return;
    }

    // 3. Durum Sorgusu (GET /status)
    request.response
      ..statusCode = HttpStatus.ok
      ..write(
        jsonEncode({
          'service': 'Mob Kitchen Smart Hub (Android & iOS)',
          'status': 'online',
          'connected_peers': _connectedSockets.length,
          'udp_discovery_port': _udpSocket?.port ?? defaultUdpDiscoveryPort,
          'endpoints': ['/status', '/telemetry', '/sync', '/ws'],
        }),
      );
    await request.response.close();
  }

  void _broadcastToWebSocketsOnly(Map<String, dynamic> payload) {
    final encoded = jsonEncode(payload);
    for (final socket in _connectedSockets.toList()) {
      try {
        socket.add(encoded);
      } catch (_) {
        _removeSocket(socket);
      }
    }
  }

  /// Bağlı tüm WebSocket istemcilerine (hem gelen sunucu soketlerine hem giden istemci soketine)
  /// JSON paketi yayınlar; aktif WebSocket yoksa ve eş IP tanımlıysa HTTP `/sync` fallback kullanır.
  void broadcastJson(Map<String, dynamic> payload) {
    final outgoing = Map<String, dynamic>.from(payload);
    _ensurePacketId(outgoing);
    _markPacketSeen(outgoing);
    _broadcastToWebSocketsOnly(outgoing);
    if (_connectedSockets.isEmpty && _configuredPeerIp != null && _configuredPeerIp!.isNotEmpty) {
      unawaited(
        sendPacketToPeerHttp(
          hostIp: _configuredPeerIp!,
          port: _configuredPeerPort ?? 8765,
          payload: outgoing,
        ),
      );
    }
  }

  /// Başka bir telefonun veya ESP32 düğümünün HTTP `/sync` uç noktasına paket gönderir.
  Future<bool> sendPacketToPeerHttp({
    required String hostIp,
    required int port,
    required Map<String, dynamic> payload,
  }) async {
    configurePeerEndpoint(hostIp, port);
    final outgoing = Map<String, dynamic>.from(payload);
    _ensurePacketId(outgoing);
    _markPacketSeen(outgoing);
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 3);
    try {
      final uri = Uri.parse('http://$hostIp:$port/sync');
      final req = await client.postUrl(uri);
      req.headers.contentType = ContentType.json;
      req.write(jsonEncode(outgoing));
      final resp = await req.close();
      return resp.statusCode == HttpStatus.ok;
    } catch (_) {
      return false;
    } finally {
      client.close();
    }
  }

  Future<void> stopServer() async {
    stopUdpDiscovery();
    for (final s in _connectedSockets.toList()) {
      try {
        await s.close();
      } catch (_) {}
    }
    _connectedSockets.clear();
    _outboundSocketsByEndpoint.clear();
    _seenPacketIds.clear();
    onClientCountChanged?.call(0);
    await _httpServer?.close(force: true);
    _httpServer = null;
  }
}
