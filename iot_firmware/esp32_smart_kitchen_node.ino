/*
 * Mob Kitchen — ESP32 Smart Kitchen IoT Node Firmware (BLE 5.0 GATT + Wi-Fi Telemetry)
 *
 * Donanım Uyumluluğu:
 * - ESP32 / ESP32-S3 / ESP32-C3
 * - DS18B20 veya MAX6675 Paslanmaz Çelik Yemek Termometresi Probu (GPIO 4)
 * - HX711 + 5kg Yük Hücresi (Load Cell) Akıllı Mutfak Tartısı (DOUT: GPIO 16, SCK: GPIO 17)
 *
 * Desteklenen Çift Protokol:
 * 1. Bluetooth Low Energy (BLE GATT Server):
 *    - Environmental Sensing Service (UUID: 0x181A) -> Temperature Characteristic (0x2A6E, int16 0.01°C)
 *    - Weight Scale Service (UUID: 0x181D)          -> Weight Characteristic (0x2A9D, uint16 0.1g)
 * 2. Wi-Fi LAN HTTP POST Telemetri İstemcisi:
 *    - Mob Kitchen uygulamasının `http://<TELEFON_IP>:8765/telemetry` adresine
 *      saniyede bir JSON (`{"type":"telemetry","sender":"ESP32-S3","temp_c":72.4,"weight_g":400.0}`) gönderir.
 */

#include <WiFi.h>
#include <HTTPClient.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

const char* WIFI_SSID     = "YOUR_WIFI_SSID";
const char* WIFI_PASSWORD = "YOUR_WIFI_PASSWORD";
const char* PHONE_HUB_URL = "http://192.168.1.42:8765/telemetry";

#define SERVICE_ENV_SENSING_UUID   "0000181a-0000-1000-8000-00805f9b34fb"
#define CHAR_TEMPERATURE_UUID      "00002a6e-0000-1000-8000-00805f9b34fb"
#define SERVICE_WEIGHT_SCALE_UUID  "0000181d-0000-1000-8000-00805f9b34fb"
#define CHAR_WEIGHT_MEAS_UUID      "00002a9d-0000-1000-8000-00805f9b34fb"

BLECharacteristic* pTempCharacteristic = nullptr;
BLECharacteristic* pWeightCharacteristic = nullptr;
bool bleClientConnected = false;

float currentTempC = 25.0;
float currentWeightG = 0.0;

class KitchenServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) override { bleClientConnected = true; }
  void onDisconnect(BLEServer* pServer) override {
    bleClientConnected = false;
    pServer->getAdvertising()->start();
  }
};

void setup() {
  Serial.begin(115200);

  // 1. BLE GATT Sunucusunu Başlat
  BLEDevice::init("MobKitchen-ESP32-Node");
  BLEServer* pServer = BLEDevice::createServer();
  pServer->setCallbacks(new KitchenServerCallbacks());

  // Sıcaklık Servisi (0x181A)
  BLEService* pEnvService = pServer->createService(SERVICE_ENV_SENSING_UUID);
  pTempCharacteristic = pEnvService->createCharacteristic(
    CHAR_TEMPERATURE_UUID,
    BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY
  );
  pTempCharacteristic->addDescriptor(new BLE2902());
  pEnvService->start();

  // Tartı Servisi (0x181D)
  BLEService* pScaleService = pServer->createService(SERVICE_WEIGHT_SCALE_UUID);
  pWeightCharacteristic = pScaleService->createCharacteristic(
    CHAR_WEIGHT_MEAS_UUID,
    BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY
  );
  pWeightCharacteristic->addDescriptor(new BLE2902());
  pScaleService->start();

  BLEAdvertising* pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_ENV_SENSING_UUID);
  pAdvertising->addServiceUUID(SERVICE_WEIGHT_SCALE_UUID);
  pAdvertising->setScanResponse(true);
  BLEDevice::startAdvertising();

  // 2. Wi-Fi Bağlantısını Başlat
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
}

void notifyBleTelemetry(float tempC, float weightG) {
  if (!bleClientConnected) return;

  // GATT 0x2A6E: int16 little-endian (0.01 °C)
  int16_t rawTemp = (int16_t)(tempC * 100.0f);
  uint8_t tempBytes[2] = {
    (uint8_t)(rawTemp & 0xFF),
    (uint8_t)((rawTemp >> 8) & 0xFF)
  };
  pTempCharacteristic->setValue(tempBytes, 2);
  pTempCharacteristic->notify();

  // GATT 0x2A9D: flags (1 byte) + uint16 little-endian (0.1 g)
  uint16_t rawWeight = (uint16_t)(weightG * 10.0f);
  uint8_t weightBytes[3] = {
    0x00,
    (uint8_t)(rawWeight & 0xFF),
    (uint8_t)((rawWeight >> 8) & 0xFF)
  };
  pWeightCharacteristic->setValue(weightBytes, 3);
  pWeightCharacteristic->notify();
}

void postWifiTelemetry(float tempC, float weightG) {
  if (WiFi.status() != WL_CONNECTED) return;
  HTTPClient http;
  http.begin(PHONE_HUB_URL);
  http.addHeader("Content-Type", "application/json");
  String payload = String("{\"type\":\"telemetry\",\"sender\":\"ESP32-S3-Node\",\"temp_c\":") +
                   String(tempC, 1) + ",\"weight_g\":" + String(weightG, 1) + "}";
  http.POST(payload);
  http.end();
}

void loop() {
  // Sensör okuma & test döngüsü
  notifyBleTelemetry(currentTempC, currentWeightG);
  postWifiTelemetry(currentTempC, currentWeightG);
  delay(1000);
}
