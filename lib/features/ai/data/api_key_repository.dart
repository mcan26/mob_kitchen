import 'package:shared_preferences/shared_preferences.dart';

/// Gemini API anahtarı yönetimi.
///
/// Öncelik sırası:
/// 1. Kullanıcının uygulama içinden `SharedPreferences`'a kaydettiği özel anahtar.
/// 2. Derleme sırasında `--dart-define=GEMINI_API_KEY=...` ile verilen anahtar.
class ApiKeyRepository {
  ApiKeyRepository([this._prefs]);

  final SharedPreferences? _prefs;

  static const String _prefKey = 'gemini_custom_api_key';
  static const String _envKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  /// Etkin API anahtarını döner (varsa özel anahtar, yoksa derleme anahtarı).
  String getApiKey() {
    final custom = _prefs?.getString(_prefKey)?.trim();
    if (custom != null && custom.isNotEmpty) {
      return custom;
    }
    return _envKey.trim();
  }

  /// Kullanıcının uygulama içinden belirlediği anahtarı kaydeder.
  Future<void> setCustomApiKey(String key) async {
    final trimmed = key.trim();
    if (trimmed.isEmpty) {
      await clearCustomApiKey();
    } else {
      await _prefs?.setString(_prefKey, trimmed);
    }
  }

  /// Özel anahtarı temizler (derleme anahtarına döner).
  Future<void> clearCustomApiKey() async {
    await _prefs?.remove(_prefKey);
  }

  /// Kullanıcının elle bir anahtar girip girmediği.
  bool get hasCustomKey {
    final custom = _prefs?.getString(_prefKey)?.trim();
    return custom != null && custom.isNotEmpty;
  }

  /// Herhangi bir anahtar (ortam veya özel) tanımlı mı?
  bool get hasValidApiKey => getApiKey().isNotEmpty;

  /// Güvenli gösterim için maskelenmiş anahtar (örn. `AIza...9xQ`).
  String get maskedApiKey {
    final key = getApiKey();
    if (key.length <= 8) return '****';
    return '${key.substring(0, 4)}...${key.substring(key.length - 4)}';
  }
}
