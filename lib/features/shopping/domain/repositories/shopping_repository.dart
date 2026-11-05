import '../entities/shopping_list_item.dart';
import '../services/smart_shopping_aggregator.dart';

abstract interface class ShoppingRepository {
  /// Alışveriş planındaki tarifleri ve porsiyon sayılarını izler.
  Stream<List<ShoppingPlanEntry>> watchPlan();

  /// Birleştirilmiş ve reyonlara göre sıralanmış alışveriş listesini izler.
  Stream<List<ShoppingListItem>> watchItems();

  /// Alışveriş planına tarif ekler veya porsiyonunu günceller, listeyi yeniden birleştirir.
  Future<void> addOrUpdateRecipeInPlan(String recipeId, int servings);

  /// Alışveriş planından tarifi çıkarır, listeyi günceller.
  Future<void> removeRecipeFromPlan(String recipeId);

  /// Tüm planı ve alışveriş listesini temizler.
  Future<void> clearPlan();

  /// Malzemenin alındı (checked) durumunu tersine çevirir.
  Future<void> toggleItemChecked(String itemId);

  /// Malzemenin alındı (checked) durumunu ayarlar.
  Future<void> setItemChecked(String itemId, bool isChecked);

  /// Tamamlanmış (alınmış) malzemelerin işaretini kaldırır veya temizler.
  Future<void> clearCheckedItems();
}
