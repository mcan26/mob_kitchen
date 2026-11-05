import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/mob_colors.dart';
import '../domain/entities/smart_kitchen_device.dart';
import '../providers/wireless_providers.dart';

enum WirelessHubTab {
  radar('Cihaz Radarı', Icons.bluetooth_searching),
  telemetry('Canlı Telemetri', Icons.thermostat_outlined),
  coop('Wi-Fi Co-Op', Icons.wifi_tethering);

  const WirelessHubTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Android & iOS uyumlu Bluetooth Low Energy (BLE 5.0) Akıllı Termometre / Tartı
/// ve Yerel Kablosuz Ağ (Wi-Fi LAN P2P) Co-Op Senkronizasyon Merkezi.
class SmartKitchenHubScreen extends ConsumerStatefulWidget {
  const SmartKitchenHubScreen({
    super.key,
    this.initialTab = WirelessHubTab.radar,
  });

  final WirelessHubTab initialTab;

  @override
  ConsumerState<SmartKitchenHubScreen> createState() => _SmartKitchenHubScreenState();
}

class _SmartKitchenHubScreenState extends ConsumerState<SmartKitchenHubScreen> {
  late WirelessHubTab _selectedTab;
  final TextEditingController _peerIpController = TextEditingController(text: '192.168.1.55:8765');

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    Future.microtask(() {
      if (mounted) {
        ref.read(smartKitchenHubProvider.notifier).refreshNativeNetworkDiagnostics();
      }
    });
  }

  @override
  void dispose() {
    _peerIpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hubState = ref.watch(smartKitchenHubProvider);
    final notifier = ref.read(smartKitchenHubProvider.notifier);

    return Scaffold(
      backgroundColor: MobColors.background,
      appBar: AppBar(
        backgroundColor: MobColors.surface,
        title: const Text(
          'Smart Kitchen BLE & Wireless Hub',
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MobColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: hubState.connectedDevicesCount > 0
                    ? MobColors.greenSurface
                    : MobColors.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: hubState.connectedDevicesCount > 0 ? MobColors.green : MobColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    hubState.connectedDevicesCount > 0
                        ? Icons.bluetooth_connected
                        : Icons.bluetooth,
                    size: 14,
                    color: hubState.connectedDevicesCount > 0
                        ? MobColors.green
                        : MobColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${hubState.connectedDevicesCount} Aktif',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: hubState.connectedDevicesCount > 0
                          ? MobColors.green
                          : MobColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Üst Sekme Seçici
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: MobColors.border),
                ),
                child: Row(
                  children: WirelessHubTab.values.map((tab) {
                    final selected = _selectedTab == tab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = tab),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? MobColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                tab.icon,
                                size: 15,
                                color: selected ? Colors.white : MobColors.textSecondary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                tab.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: selected ? Colors.white : MobColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Gövde
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: switch (_selectedTab) {
                  WirelessHubTab.radar => _buildRadarTab(hubState, notifier),
                  WirelessHubTab.telemetry => _buildTelemetryTab(hubState, notifier),
                  WirelessHubTab.coop => _buildCoOpTab(hubState, notifier),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarTab(SmartKitchenHubState state, SmartKitchenHubNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Mimari Bilgi Kartı
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A2E3B), Color(0xFF1A1A24)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2E5B78)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.radar, color: Color(0xFF48DBFB), size: 22),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Android & iOS Çapraz Platform Kablosuz Köprü',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: MobColors.textPrimary,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: state.isScanning ? null : notifier.scanForDevices,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MobColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: state.isScanning
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.refresh, size: 16),
                    label: Text(
                      state.isScanning ? 'Taranıyor...' : 'BLE & Ağ Tara',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Bluetooth Low Energy (GATT 0x181A / 0x181D) ve yerel Wi-Fi (WebSocket/UDP) protokollerini destekler. Fiziksel sensör bağlı değilken gerçekçi fizik motoruyla canlı telemetri üretir.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: MobColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        const Text(
          'Bulunan Akıllı Mutfak Cihazları & Düğümler',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),

        for (final device in state.devices)
          _DeviceCard(
            device: device,
            onToggleConnect: () => notifier.toggleDeviceConnection(device.id),
          ),

        const SizedBox(height: 8),
        _buildNativeDiagnosticsCard(state, notifier),
      ],
    );
  }

  Widget _buildNativeDiagnosticsCard(
    SmartKitchenHubState state,
    SmartKitchenHubNotifier notifier,
  ) {
    final diag = state.nativeDiagnostics;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MobColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.settings_input_antenna, color: MobColors.gold, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Native OS Network & Radio Diagnostics (Android ConnectivityManager / iOS Network)',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: MobColors.textPrimary,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: notifier.refreshNativeNetworkDiagnostics,
                icon: const Icon(Icons.sync, size: 15, color: MobColors.primaryLight),
                label: const Text(
                  'Sorgula',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: MobColors.primaryLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'MethodChannel: com.mobkitchen/native_network · ${diag.platform}',
            style: const TextStyle(fontSize: 11.5, color: MobColors.textSecondary),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _SmallSpecBadge(
                label: 'Taşıyıcı: ${diag.transport}',
                color: diag.isConnected ? MobColors.green : MobColors.red,
              ),
              _SmallSpecBadge(
                label: 'RSSI: ${diag.rssiDbm} dBm',
                color: MobColors.gold,
              ),
              _SmallSpecBadge(
                label: '${diag.linkSpeedMbps} Mbps (${diag.frequencyBandLabel})',
                color: MobColors.primaryLight,
              ),
              _SmallSpecBadge(
                label: 'IPv4: ${diag.ipv4Address}',
                color: MobColors.textPrimary,
              ),
              _SmallSpecBadge(
                label: 'BT Radyo: ${diag.bluetoothState}',
                color: diag.bluetoothState == 'ON' ? MobColors.green : MobColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryTab(SmartKitchenHubState state, SmartKitchenHubNotifier notifier) {
    final thermo = state.thermometer;
    final scale = state.scale;
    final etaMin = thermo.estimatedSecondsRemaining ~/ 60;
    final etaSec = thermo.estimatedSecondsRemaining % 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. BLE Akıllı Et & Tava Termometresi Kartı
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: MobColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: thermo.isTargetReached ? MobColors.green : MobColors.primaryLight.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.thermostat, color: MobColors.primaryLight, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'BLE Akıllı Et & Tava Termometresi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: MobColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: state.hasConnectedThermometer ? MobColors.greenSurface : MobColors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.hasConnectedThermometer ? 'CANLI AKIŞ' : 'SİMÜLASYON HAZIR',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        color: state.hasConnectedThermometer ? MobColors.green : MobColors.gold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Büyük Sıcaklık Göstergeleri
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: MobColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: MobColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ÇEKİRDEK (İÇ) SICAKLIK',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: MobColors.textMuted),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${thermo.currentTempC.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: thermo.isTargetReached ? MobColors.green : MobColors.primaryLight,
                            ),
                          ),
                          Text(
                            '+${thermo.rateCPerMinute.toStringAsFixed(1)} °C/dk hız',
                            style: const TextStyle(fontSize: 11.5, color: MobColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: MobColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: MobColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'HEDEF & TAVA ISISI',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: MobColors.textMuted),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${thermo.targetTempC.toStringAsFixed(0)}°C',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: MobColors.gold,
                            ),
                          ),
                          Text(
                            thermo.isTargetReached
                                ? '🎉 Hedef Sıcaklıkta!'
                                : 'Tahmini: ${etaMin}dk ${etaSec}sn',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: thermo.isTargetReached ? MobColors.green : MobColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Canlı Sıcaklık Eğrisi Grafiği
              Container(
                height: 90,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MobColors.border),
                ),
                child: CustomPaint(
                  painter: _TemperatureCurvePainter(
                    history: thermo.history,
                    targetTempC: thermo.targetTempC,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Pişirme Derecesi Hazır Seçimler (Presets)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: CulinaryTempPreset.values.map((preset) {
                    final selected = (thermo.targetTempC - preset.targetTempC).abs() < 0.5;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        selected: selected,
                        selectedColor: MobColors.primary,
                        backgroundColor: MobColors.surface,
                        label: Text(
                          '${preset.label} (${preset.targetTempC.toInt()}°C)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white : MobColors.textSecondary,
                          ),
                        ),
                        onSelected: (_) => notifier.applyTempPreset(preset),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),

              // Canlı Simülasyon Kontrolleri (Jüri / Demo için)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => notifier.simulateHeatBurst(deltaC: 7.5),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MobColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon: const Icon(Icons.local_fire_department, size: 17),
                      label: const Text('Isıyı Artır (+7.5°C)', style: TextStyle(fontSize: 12.5)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: notifier.resetThermometerToRoomTemp,
                    icon: const Icon(Icons.ac_unit, size: 16, color: MobColors.textSecondary),
                    label: const Text('Soğut (23.5°C)', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 2. BLE Akıllı Mutfak Tartısı Kartı
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: MobColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scale.isAtTarget ? MobColors.green : MobColors.border,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.scale_outlined, color: MobColors.gold, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'BLE Akıllı Mutfak Tartısı (GATT 0x181D)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: MobColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: notifier.tareScale,
                    icon: const Icon(Icons.exposure_zero, size: 16, color: MobColors.gold),
                    label: const Text(
                      'Dara Al (Tare)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: MobColors.gold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hedef: ${scale.targetIngredientName} (${scale.targetWeightGrams.toInt()} g)',
                        style: const TextStyle(fontSize: 12.5, color: MobColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${scale.netWeightGrams.toStringAsFixed(1)} g',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: scale.isAtTarget ? MobColors.green : MobColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: MobColors.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      scale.isAtTarget
                          ? '✅ Tam Gramaj!'
                          : '%${(scale.progress * 100).clamp(0, 120).toInt()} Dolu',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: scale.isAtTarget ? MobColors.green : MobColors.gold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: scale.progress.clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: MobColors.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    scale.isAtTarget ? MobColors.green : MobColors.gold,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Tartı Demo Kontrolleri
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () => notifier.pourIngredientOnScale(50),
                    child: const Text('+50g Ekle', style: TextStyle(fontSize: 12)),
                  ),
                  OutlinedButton(
                    onPressed: () => notifier.pourIngredientOnScale(100),
                    child: const Text('+100g Ekle', style: TextStyle(fontSize: 12)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final needed = scale.targetWeightGrams - scale.netWeightGrams;
                      if (needed > 0) notifier.pourIngredientOnScale(needed);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MobColors.gold,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Hedefe Tamamla (400g)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoOpTab(SmartKitchenHubState state, SmartKitchenHubNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Yerel Wi-Fi P2P Sunucu Kartı
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: MobColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: state.isLanHostRunning ? MobColors.green : MobColors.border,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wifi_tethering,
                    color: state.isLanHostRunning ? MobColors.green : MobColors.primaryLight,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wi-Fi LAN Co-Op Sunucusu (Android ↔ iOS ↔ ESP32)',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                            color: MobColors.textPrimary,
                          ),
                        ),
                        Text(
                          state.isLanHostRunning
                              ? 'Aktif Adres: http://${state.localIpAddress}:${state.lanPort} · Oda: ${state.roomCode}'
                              : 'Aynı Wi-Fi veya Hotspot üzerindeki telefonları ve sensörleri bağlayın.',
                          style: const TextStyle(fontSize: 12, color: MobColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: notifier.toggleLanCoOpServer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isLanHostRunning ? MobColors.red : MobColors.green,
                        foregroundColor: Colors.white,
                      ),
                      icon: Icon(
                        state.isLanHostRunning ? Icons.stop_circle_outlined : Icons.play_circle_outline,
                        size: 18,
                      ),
                      label: Text(
                        state.isLanHostRunning ? 'Kablosuz Odayı Kapat' : 'Kablosuz Co-Op Odası Kur',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _SmallSpecBadge(
                    label: state.isUdpDiscoveryActive
                        ? 'UDP Broadcast MANET (255.255.255.255:41234): AKTİF'
                        : 'UDP Broadcast MANET (:41234): HAZIR',
                    color: state.isUdpDiscoveryActive ? MobColors.green : MobColors.gold,
                  ),
                  _SmallSpecBadge(
                    label: 'Bağlı Eşler: ${state.connectedPeerCount}',
                    color: MobColors.primaryLight,
                  ),
                  for (final peer in state.discoveredPeers)
                    _SmallSpecBadge(
                      label: 'Keşfedilen Düğüm: $peer',
                      color: MobColors.green,
                    ),
                  if (state.lastSyncedCookStep != null)
                    _SmallSpecBadge(
                      label: 'Pişirme Adımı: ${state.lastSyncedCookStep}',
                      color: MobColors.gold,
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. Eş Cihaza Bağlan & Canlı Market Senkronu
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: MobColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Başka Bir Telefona Bağlan veya Co-Op Senkronu Test Et',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: MobColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _peerIpController,
                      style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
                      decoration: const InputDecoration(
                        hintText: 'Örn: 192.168.1.55:8765',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => notifier.sendSyncPingToPeer(_peerIpController.text),
                    child: const Text('El Sıkış (Ping)'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await notifier.simulatePeerShoppingSync();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '📲 Kablosuz Co-Op: Eş telefondan gelen paketle Süpermarket listeniz güncellendi!',
                          ),
                          backgroundColor: MobColors.green,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.sync, size: 18, color: MobColors.gold),
                  label: const Text(
                    'Eş Telefondan Canlı Market İşaretlemesi Simüle Et',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: MobColors.gold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await notifier.simulatePeerCookStepSync();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '👨‍🍳 Co-Op Cook Mode Sync: Peer step transition received over WebSocket!',
                          ),
                          backgroundColor: MobColors.primary,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.soup_kitchen_outlined, size: 18, color: MobColors.primaryLight),
                  label: const Text(
                    'Simulate Peer Cook Mode Step Sync (Co-Op Adım Senkronu)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: MobColors.primaryLight),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Canlı Protokol & Paket Günlüğü (Packet Inspector)
        const Text(
          'Canlı Kablosuz Paket & Protokol Günlüğü (Packet Log)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        if (state.syncEvents.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MobColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: MobColors.border),
            ),
            child: const Text(
              'Henüz kablosuz paket trafiği yok. Yukarıdan bir BLE cihazına bağlanın veya Kablosuz Co-Op odasını başlatın.',
              style: TextStyle(fontSize: 12.5, color: MobColors.textMuted),
            ),
          )
        else
          for (final evt in state.syncEvents.take(8))
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MobColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MobColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.swap_horiz, size: 16, color: MobColors.primaryLight),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evt.senderDevice,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: MobColors.gold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          evt.description,
                          style: const TextStyle(fontSize: 12, color: MobColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.onToggleConnect,
  });

  final SmartKitchenDevice device;
  final VoidCallback onToggleConnect;

  @override
  Widget build(BuildContext context) {
    final icon = switch (device.type) {
      KitchenDeviceType.meatThermometer => Icons.thermostat,
      KitchenDeviceType.smartScale => Icons.scale_outlined,
      KitchenDeviceType.esp32SensorNode => Icons.developer_board,
      KitchenDeviceType.peerPhone => Icons.phone_iphone,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: device.isConnected ? MobColors.green : MobColors.border,
          width: device.isConnected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: device.isConnected ? MobColors.greenSurface : MobColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 22,
              color: device.isConnected ? MobColors.green : MobColors.primaryLight,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: MobColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  device.type.specSubtitle,
                  style: const TextStyle(fontSize: 11.5, color: MobColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _SmallSpecBadge(label: device.protocol.badge, color: MobColors.gold),
                    _SmallSpecBadge(
                      label: '${device.rssiDbm} dBm (%${device.signalQualityPercent})',
                      color: MobColors.textSecondary,
                    ),
                    _SmallSpecBadge(
                      label: '🔋 %${device.batteryPercent}',
                      color: MobColors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onToggleConnect,
            style: ElevatedButton.styleFrom(
              backgroundColor: device.isConnected ? MobColors.surface : MobColors.primary,
              foregroundColor: device.isConnected ? MobColors.green : Colors.white,
              side: device.isConnected ? const BorderSide(color: MobColors.green) : null,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              device.isConnected ? 'Bağlı ✓' : 'Bağlan',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallSpecBadge extends StatelessWidget {
  const _SmallSpecBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: MobColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: MobColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

class _TemperatureCurvePainter extends CustomPainter {
  _TemperatureCurvePainter({
    required this.history,
    required this.targetTempC,
  });

  final List<double> history;
  final double targetTempC;

  @override
  void paint(Canvas canvas, Size size) {
    if (history.isEmpty) return;

    const minTemp = 20.0;
    final maxTemp = (targetTempC + 20.0).clamp(90.0, 220.0);

    // Hedef çizgisi (kesikli altın çizgi)
    final targetY = size.height - ((targetTempC - minTemp) / (maxTemp - minTemp)) * size.height;
    final targetPaint = Paint()
      ..color = MobColors.gold.withValues(alpha: 0.5)
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(0, targetY.clamp(0, size.height)), Offset(size.width, targetY.clamp(0, size.height)), targetPaint);

    // Sıcaklık eğrisi
    final linePaint = Paint()
      ..color = MobColors.primaryLight
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (var i = 0; i < history.length; i++) {
      final x = history.length == 1 ? size.width / 2 : (i / (history.length - 1)) * size.width;
      final normalized = ((history[i] - minTemp) / (maxTemp - minTemp)).clamp(0.0, 1.0);
      final y = size.height - normalized * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _TemperatureCurvePainter oldDelegate) {
    return oldDelegate.history != history || oldDelegate.targetTempC != targetTempC;
  }
}
