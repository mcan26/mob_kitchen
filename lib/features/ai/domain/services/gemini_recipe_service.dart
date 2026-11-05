import 'dart:typed_data';

import '../../../recipes/domain/entities/recipe.dart';

abstract interface class GeminiRecipeService {
  /// Dolaptaki malzemelerden (ve varsa çekilen fotoğraftan) Mob tarzı yeni tarif üretir.
  Future<Recipe> generateRecipeFromPantry({
    required List<String> ingredients,
    Uint8List? imageBytes,
    String? mimeType,
    String? additionalPrompt,
  });

  /// Mevcut bir yerel tarifi kullanıcının isteğine göre (örn. tavada/fırınsız yap,
  /// proteini artır, x malzemesini değiştir) yeniden kurgular (Remix).
  Future<Recipe> remixRecipe({
    required Recipe sourceRecipe,
    required String remixInstruction,
  });

  /// Pişirme anında o anki adım bağlamında canlı sous-chef desteği sağlar.
  /// (örn. "Sos çok sıvı kaldı nasıl bağlarım?", "Tavuk yapışıyor ne yapmalıyım?")
  Future<String> askSousChef({
    required Recipe currentRecipe,
    required int currentStepNumber,
    required String question,
  });

  /// Sosyal medya (Instagram Reels, TikTok, YouTube Shorts), web linki veya
  /// kopyalanmış ham tarif metninden yapılandırılmış Mob Kitchen reçetesi çıkarır.
  Future<Recipe> importRecipeFromSocialOrText({
    required String urlOrText,
  });
}
