import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/features/ai/data/api_key_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiKeyRepository', () {
    test('başlangıçta özel anahtar yoksa ortam anahtarını veya boş döner', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = ApiKeyRepository(prefs);

      expect(repo.hasCustomKey, isFalse);
    });

    test('özel anahtar kaydedilince öncelikli olarak döner', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = ApiKeyRepository(prefs);

      await repo.setCustomApiKey('AIzaSyD-TestKey123456');

      expect(repo.hasCustomKey, isTrue);
      expect(repo.getApiKey(), 'AIzaSyD-TestKey123456');
      expect(repo.hasValidApiKey, isTrue);
      expect(repo.maskedApiKey, 'AIza...3456');
    });

    test('özel anahtar temizlenince boş veya ortam anahtarına döner', () async {
      SharedPreferences.setMockInitialValues({'gemini_custom_api_key': 'temp_key'});
      final prefs = await SharedPreferences.getInstance();
      final repo = ApiKeyRepository(prefs);

      expect(repo.hasCustomKey, isTrue);

      await repo.clearCustomApiKey();
      expect(repo.hasCustomKey, isFalse);
      expect(repo.getApiKey(), isEmpty);
    });

    test('kısa anahtarlar için maskedApiKey dört yıldız döner', () async {
      SharedPreferences.setMockInitialValues({'gemini_custom_api_key': '123'});
      final prefs = await SharedPreferences.getInstance();
      final repo = ApiKeyRepository(prefs);

      expect(repo.maskedApiKey, '****');
    });
  });
}
