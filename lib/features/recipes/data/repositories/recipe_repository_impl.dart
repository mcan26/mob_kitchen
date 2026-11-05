import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../mappers/recipe_mapper.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Recipe>> watchAll() {
    final query = _db.select(_db.recipes)
      ..orderBy([
        (t) => OrderingTerm.desc(t.isBuiltIn),
        (t) => OrderingTerm.desc(t.createdAt),
        (t) => OrderingTerm.asc(t.title),
      ]);
    return query.watch().asyncMap(_hydrate);
  }

  @override
  Stream<Recipe?> watchById(String id) {
    final query = _db.select(_db.recipes)..where((t) => t.id.equals(id));
    return query.watch().asyncMap((rows) async {
      final recipes = await _hydrate(rows);
      return recipes.isEmpty ? null : recipes.first;
    });
  }

  @override
  Future<Recipe?> getById(String id) async {
    final rows = await (_db.select(_db.recipes)..where((t) => t.id.equals(id))).get();
    final recipes = await _hydrate(rows);
    return recipes.isEmpty ? null : recipes.first;
  }

  @override
  Future<void> save(Recipe recipe) => _db.transaction(() => upsertRecipe(_db, recipe));

  @override
  Future<void> toggleFavorite(String id) async {
    final row = await (_db.select(_db.recipes)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    await (_db.update(_db.recipes)..where((t) => t.id.equals(id)))
        .write(RecipesCompanion(isFavorite: Value(!row.isFavorite)));
  }

  @override
  Future<void> delete(String id) async {
    final row = await (_db.select(_db.recipes)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    if (row.isBuiltIn) {
      throw StateError('Built-in recipes cannot be deleted: $id');
    }
    await (_db.delete(_db.recipes)..where((t) => t.id.equals(id))).go();
  }

  /// Tarif satırını upsert eder; malzeme ve adımları tamamen yeniden yazar.
  /// Çağıran taraf bir transaction içinde olmalıdır.
  static Future<void> upsertRecipe(AppDatabase db, Recipe recipe) async {
    await db.into(db.recipes).insertOnConflictUpdate(RecipeMapper.toRecipeCompanion(recipe));
    await (db.delete(db.recipeIngredients)..where((t) => t.recipeId.equals(recipe.id))).go();
    await (db.delete(db.recipeSteps)..where((t) => t.recipeId.equals(recipe.id))).go();
    await db.batch((b) {
      b.insertAll(db.recipeIngredients, RecipeMapper.toIngredientCompanions(recipe));
      b.insertAll(db.recipeSteps, RecipeMapper.toStepCompanions(recipe));
    });
  }

  Future<List<Recipe>> _hydrate(List<RecipeRow> rows) async {
    if (rows.isEmpty) return const [];
    final ids = rows.map((r) => r.id).toList();

    final ingredientRows =
        await (_db.select(_db.recipeIngredients)..where((t) => t.recipeId.isIn(ids))).get();
    final stepRows = await (_db.select(_db.recipeSteps)..where((t) => t.recipeId.isIn(ids))).get();

    final ingredientsByRecipe = <String, List<RecipeIngredientRow>>{};
    for (final r in ingredientRows) {
      (ingredientsByRecipe[r.recipeId] ??= []).add(r);
    }
    final stepsByRecipe = <String, List<RecipeStepRow>>{};
    for (final r in stepRows) {
      (stepsByRecipe[r.recipeId] ??= []).add(r);
    }

    return rows
        .map((row) => RecipeMapper.toEntity(
              row,
              ingredientsByRecipe[row.id] ?? const [],
              stepsByRecipe[row.id] ?? const [],
            ))
        .toList(growable: false);
  }
}
