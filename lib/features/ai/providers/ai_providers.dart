import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../profile/providers/profile_providers.dart';
import '../data/api_key_repository.dart';
import '../data/gemini_recipe_service_impl.dart';
import '../domain/services/gemini_recipe_service.dart';

final apiKeyRepositoryProvider = Provider<ApiKeyRepository>((ref) {
  try {
    final prefs = ref.watch(sharedPreferencesProvider);
    return ApiKeyRepository(prefs);
  } catch (_) {
    return ApiKeyRepository();
  }
});

/// API anahtarı durumunu yöneten Notifier.
class ApiKeyNotifier extends Notifier<String> {
  @override
  String build() => ref.read(apiKeyRepositoryProvider).getApiKey();

  Future<void> setCustomKey(String key) async {
    await ref.read(apiKeyRepositoryProvider).setCustomApiKey(key);
    state = ref.read(apiKeyRepositoryProvider).getApiKey();
  }

  Future<void> clearCustomKey() async {
    await ref.read(apiKeyRepositoryProvider).clearCustomApiKey();
    state = ref.read(apiKeyRepositoryProvider).getApiKey();
  }
}

final activeApiKeyProvider = NotifierProvider<ApiKeyNotifier, String>(ApiKeyNotifier.new);

final geminiRecipeServiceProvider = Provider<GeminiRecipeService>((ref) {
  final apiKeyRepo = ref.watch(apiKeyRepositoryProvider);
  return GeminiRecipeServiceImpl(
    apiKeyRepository: apiKeyRepo,
    getTasteProfile: () => ref.read(personalTasteProfileProvider),
  );
});
