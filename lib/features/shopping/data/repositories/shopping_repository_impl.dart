import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';
import '../../../recipes/domain/repositories/recipe_repository.dart';
import '../../domain/entities/shopping_list_item.dart';
import '../../domain/repositories/shopping_repository.dart';
import '../../domain/services/smart_shopping_aggregator.dart';

class ShoppingRepositoryImpl implements ShoppingRepository {
  ShoppingRepositoryImpl({
    required AppDatabase db,
    required RecipeRepository recipeRepo,
  })  : _db = db,
        _recipeRepo = recipeRepo;

  final AppDatabase _db;
  final RecipeRepository _recipeRepo;

  @override
  Stream<List<ShoppingPlanEntry>> watchPlan() {
    return _db.select(_db.shoppingPlanRecipes).watch().asyncMap((rows) async {
      final entries = <ShoppingPlanEntry>[];
      for (final row in rows) {
        final recipe = await _recipeRepo.getById(row.recipeId);
        if (recipe != null) {
          entries.add(ShoppingPlanEntry(recipe: recipe, servings: row.servings));
        }
      }
      return entries;
    });
  }

  @override
  Stream<List<ShoppingListItem>> watchItems() {
    return _db.select(_db.shoppingListItems).watch().map((rows) {
      final items = rows.map(_rowToEntity).toList();
      items.sort((a, b) {
        final aisleCmp = a.aisleCategory.shoppingOrder.compareTo(b.aisleCategory.shoppingOrder);
        if (aisleCmp != 0) return aisleCmp;
        return a.name.compareTo(b.name);
      });
      return items;
    });
  }

  @override
  Future<void> addOrUpdateRecipeInPlan(String recipeId, int servings) async {
    if (servings <= 0) {
      await removeRecipeFromPlan(recipeId);
      return;
    }

    await _db.into(_db.shoppingPlanRecipes).insertOnConflictUpdate(
          ShoppingPlanRecipesCompanion.insert(
            recipeId: recipeId,
            servings: servings,
          ),
        );
    await _recalculateList();
  }

  @override
  Future<void> removeRecipeFromPlan(String recipeId) async {
    await (_db.delete(_db.shoppingPlanRecipes)..where((t) => t.recipeId.equals(recipeId))).go();
    await _recalculateList();
  }

  @override
  Future<void> clearPlan() async {
    await _db.transaction(() async {
      await _db.delete(_db.shoppingPlanRecipes).go();
      await _db.delete(_db.shoppingListItems).go();
    });
  }

  @override
  Future<void> toggleItemChecked(String itemId) async {
    final row = await (_db.select(_db.shoppingListItems)..where((t) => t.id.equals(itemId)))
        .getSingleOrNull();
    if (row == null) return;
    await (_db.update(_db.shoppingListItems)..where((t) => t.id.equals(itemId))).write(
      ShoppingListItemsCompanion(isChecked: Value(!row.isChecked)),
    );
  }

  @override
  Future<void> setItemChecked(String itemId, bool isChecked) async {
    await (_db.update(_db.shoppingListItems)..where((t) => t.id.equals(itemId))).write(
      ShoppingListItemsCompanion(isChecked: Value(isChecked)),
    );
  }

  @override
  Future<void> clearCheckedItems() async {
    await (_db.delete(_db.shoppingListItems)..where((t) => t.isChecked.equals(true))).go();
  }

  Future<void> _recalculateList() async {
    await _db.transaction(() async {
      final planRows = await _db.select(_db.shoppingPlanRecipes).get();
      final existingItems = await _db.select(_db.shoppingListItems).get();
      final checkedMap = {for (final row in existingItems) row.id: row.isChecked};

      final entries = <ShoppingPlanEntry>[];
      for (final row in planRows) {
        final recipe = await _recipeRepo.getById(row.recipeId);
        if (recipe != null) {
          entries.add(ShoppingPlanEntry(recipe: recipe, servings: row.servings));
        }
      }

      final aggregated = SmartShoppingAggregator.aggregate(
        planEntries: entries,
        existingCheckedStates: checkedMap,
      );

      await _db.delete(_db.shoppingListItems).go();
      if (aggregated.isNotEmpty) {
        await _db.batch((b) {
          b.insertAll(
            _db.shoppingListItems,
            aggregated.map((item) => ShoppingListItemsCompanion.insert(
                  id: item.id,
                  name: item.name,
                  aggregatedAmount: item.aggregatedAmount,
                  unit: item.unit.jsonValue,
                  aisleCategory: item.aisleCategory.jsonValue,
                  buyingTip: Value(item.buyingTip),
                  substituteOption: Value(item.substituteOption),
                  isChecked: Value(item.isChecked),
                  sourceRecipeTitles: item.sourceRecipeTitles,
                )),
          );
        });
      }
    });
  }

  static ShoppingListItem _rowToEntity(ShoppingListItemRow row) {
    return ShoppingListItem(
      id: row.id,
      name: row.name,
      aggregatedAmount: row.aggregatedAmount,
      unit: MeasurementUnit.fromJson(row.unit),
      aisleCategory: AisleCategory.fromJson(row.aisleCategory),
      buyingTip: row.buyingTip,
      substituteOption: row.substituteOption,
      isChecked: row.isChecked,
      sourceRecipeTitles: row.sourceRecipeTitles,
    );
  }
}
