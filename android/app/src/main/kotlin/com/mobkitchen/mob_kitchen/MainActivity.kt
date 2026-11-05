package com.mobkitchen.mob_kitchen

import android.bluetooth.BluetoothManager
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.wifi.WifiManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.Inet4Address
import java.net.NetworkInterface

class MainActivity : FlutterActivity() {
    companion object {
        private const val NATIVE_NETWORK_CHANNEL = "com.mobkitchen/native_network"
        private const val MULTICAST_LOCK_TAG = "mob_kitchen_udp_manet_lock"
    }

    private var multicastLock: WifiManager.MulticastLock? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            NATIVE_NETWORK_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getNativeNetworkDiagnostics" -> {
                    ensureMulticastLock(true)
                    result.success(collectNativeNetworkDiagnostics())
                }
                "setMulticastLock" -> {
                    val enable = call.argument<Boolean>("enabled") ?: true
                    result.success(ensureMulticastLock(enable))
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        ensureMulticastLock(false)
        super.onDestroy()
    }

    private fun ensureMulticastLock(enable: Boolean): Boolean {
        return try {
            val wifiManager =
                applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (enable) {
                if (multicastLock == null && wifiManager != null) {
                    multicastLock = wifiManager.createMulticastLock(MULTICAST_LOCK_TAG).apply {
                        setReferenceCounted(false)
                    }
                }
                if (multicastLock?.isHeld == false) {
                    multicastLock?.acquire()
                }
            } else {
                if (multicastLock?.isHeld == true) {
                    multicastLock?.release()
                }
            }
            multicastLock?.isHeld == true
        } catch (_: Throwable) {
            false
        }
    }

    private fun isPrivateLanIpv4(host: String): Boolean {
        if (host.startsWith("192.168.") || host.startsWith("10.")) return true
        if (host.startsWith("172.")) {
            val parts = host.split('.')
            val secondOctet = parts.getOrNull(1)?.toIntOrNull() ?: return false
            return secondOctet in 16..31
        }
        return false
    }

    private fun collectNativeNetworkDiagnostics(): Map<String, Any> {
        val connectivityManager =
            applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager
        val wifiManager =
            applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
        val bluetoothManager =
            applicationContext.getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager

        var transport = "NONE"
        var isConnected = false
        var rssiDbm = -55
        var hasSignalFromCaps = false
        var linkSpeedMbps = 300
        var frequencyMhz = 5180
        var ipv4Address = "127.0.0.1"

        try {
            val activeNetwork = connectivityManager?.activeNetwork
            val caps = if (activeNetwork != null) {
                connectivityManager.getNetworkCapabilities(activeNetwork)
            } else {
                null
            }
            if (caps != null) {
                isConnected = caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) ||
                        caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) ||
                        caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)
                transport = when {
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "WIFI"
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "CELLULAR"
                    caps.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ETHERNET"
                    else -> "OTHER"
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    val signal = caps.signalStrength
                    if (signal != NetworkCapabilities.SIGNAL_STRENGTH_UNSPECIFIED && signal in -120..-1) {
                        rssiDbm = signal
                        hasSignalFromCaps = true
                    }
                }
            }

            val linkProps = if (activeNetwork != null) {
                connectivityManager.getLinkProperties(activeNetwork)
            } else {
                null
            }
            val linkCandidates = linkProps?.linkAddresses
                ?.mapNotNull { it.address }
                ?.filterIsInstance<Inet4Address>()
                ?.filter { !it.isLoopbackAddress }
                ?.mapNotNull { it.hostAddress }
                .orEmpty()
            val preferredLinkIpv4 = linkCandidates.firstOrNull { isPrivateLanIpv4(it) }
                ?: linkCandidates.firstOrNull()
            if (!preferredLinkIpv4.isNullOrEmpty()) {
                ipv4Address = preferredLinkIpv4
            }
        } catch (_: Throwable) {}

        try {
            @Suppress("DEPRECATION")
            val wifiInfo = wifiManager?.connectionInfo
            if (wifiInfo != null) {
                if (!hasSignalFromCaps && wifiInfo.rssi in -120..-1) {
                    rssiDbm = wifiInfo.rssi
                }
                if (wifiInfo.linkSpeed > 0) {
                    linkSpeedMbps = wifiInfo.linkSpeed
                }
                if (wifiInfo.frequency > 0) {
                    frequencyMhz = wifiInfo.frequency
                }
            }
        } catch (_: Throwable) {}

        if (ipv4Address == "127.0.0.1" || !isPrivateLanIpv4(ipv4Address)) {
            try {
                var fallbackNonLoopback: String? = null
                var privateLanCandidate: String? = null
                val interfaces = NetworkInterface.getNetworkInterfaces()
                outerLoop@ while (interfaces != null && interfaces.hasMoreElements()) {
                    val iface = interfaces.nextElement()
                    val ifaceName = iface.name?.lowercase() ?: ""
                    val isWifiOrHotspotIface = ifaceName.startsWith("wlan") ||
                            ifaceName.startsWith("ap") ||
                            ifaceName.startsWith("swlan")
                    val addrs = iface.inetAddresses
                    while (addrs.hasMoreElements()) {
                        val addr = addrs.nextElement()
                        if (addr is Inet4Address && !addr.isLoopbackAddress) {
                            val host = addr.hostAddress ?: continue
                            if (fallbackNonLoopback == null) {
                                fallbackNonLoopback = host
                            }
                            if (isPrivateLanIpv4(host)) {
                                privateLanCandidate = host
                                if (isWifiOrHotspotIface) {
                                    break@outerLoop
                                }
                            }
                        }
                    }
                }
                if (privateLanCandidate != null) {
                    ipv4Address = privateLanCandidate
                } else if (ipv4Address == "127.0.0.1" && fallbackNonLoopback != null) {
                    ipv4Address = fallbackNonLoopback
                }
            } catch (_: Throwable) {}
        }

        val bluetoothState = try {
            val adapter = bluetoothManager?.adapter
            when {
                adapter == null -> "UNAVAILABLE"
                adapter.isEnabled -> "ON"
                else -> "OFF"
            }
        } catch (_: Throwable) {
            "UNKNOWN"
        }

        return mapOf(
            "platform" to "Android ${Build.VERSION.RELEASE} (API ${Build.VERSION.SDK_INT})",
            "transport" to transport,
            "isConnected" to isConnected,
            "rssiDbm" to rssiDbm,
            "linkSpeedMbps" to linkSpeedMbps,
            "frequencyMhz" to frequencyMhz,
            "ipv4Address" to ipv4Address,
            "bluetoothState" to bluetoothState,
            "multicastLockHeld" to (multicastLock?.isHeld == true),
        )
    }
}
