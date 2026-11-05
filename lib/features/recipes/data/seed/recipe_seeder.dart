import '../../../../core/database/app_database.dart';
import '../../domain/entities/recipe.dart';
import '../repositories/recipe_repository_impl.dart';
import 'initial_recipes_seed.dart';

/// Yerleşik "Mob Classics" kataloğunu ilk açılışta (ve katalog güncellendiğinde)
/// yerel veritabanına yükler. İnternet gerektirmez.
class RecipeSeeder {
  RecipeSeeder(this._db);

  final AppDatabase _db;

  static const _seedVersionKey = 'seed_version';

  /// [kSeedVersion] değişmediyse hiçbir şey yapmaz.
  /// Güncellemede: yerleşik tarifler upsert edilir, kullanıcının favori
  /// işaretleri ve AI tarifleri korunur, katalogdan kaldırılanlar silinir.
  Future<void> seedIfNeeded({
    List<Recipe> recipes = kInitialRecipes,
    int version = kSeedVersion,
  }) async {
    final stored = await (_db.select(_db.appMeta)..where((t) => t.key.equals(_seedVersionKey)))
        .getSingleOrNull();
    if (stored?.value == '$version') return;

    await _db.transaction(() async {
      final existing = await (_db.select(_db.recipes)..where((t) => t.isBuiltIn.equals(true))).get();
      final favoriteIds = {for (final r in existing.where((r) => r.isFavorite)) r.id};

      final seedIds = recipes.map((r) => r.id).toSet();
      final orphanIds = existing.map((r) => r.id).where((id) => !seedIds.contains(id)).toList();
      if (orphanIds.isNotEmpty) {
        await (_db.delete(_db.recipes)..where((t) => t.id.isIn(orphanIds))).go();
      }

      // Katalog sırası korunsun diye: ilk tarif en yeni createdAt'e sahip olur.
      final base = DateTime.utc(2025, 1, 1);
      for (final (i, recipe) in recipes.indexed) {
        await RecipeRepositoryImpl.upsertRecipe(
          _db,
          recipe.copyWith(
            isBuiltIn: true,
            isFavorite: favoriteIds.contains(recipe.id),
            createdAt: base.add(Duration(seconds: recipes.length - i)),
          ),
        );
      }

      await _db.into(_db.appMeta).insertOnConflictUpdate(
            AppMetaCompanion.insert(key: _seedVersionKey, value: '$version'),
          );
    });
  }
}
