import '../entities/recipe.dart';

abstract interface class RecipeRepository {
  /// Tüm tarifler (yerleşik + AI), yeniden eskiye / yerleşikler önce.
  Stream<List<Recipe>> watchAll();

  Stream<Recipe?> watchById(String id);

  Future<Recipe?> getById(String id);

  /// Tarifi (ve malzeme/adımlarını) ekler ya da günceller.
  /// Gemini çıktıları da bu yoldan kaydedilir.
  Future<void> save(Recipe recipe);

  Future<void> toggleFavorite(String id);

  /// Yerleşik tarifler silinemez ([StateError] fırlatır).
  Future<void> delete(String id);
}
