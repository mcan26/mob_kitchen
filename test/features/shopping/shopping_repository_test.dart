import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/database/app_database.dart';
import 'package:mob_kitchen/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/data/seed/recipe_seeder.dart';
import 'package:mob_kitchen/features/shopping/data/repositories/shopping_repository_impl.dart';

void main() {
  late AppDatabase db;
  late RecipeRepositoryImpl recipeRepo;
  late ShoppingRepositoryImpl shoppingRepo;
  late RecipeSeeder seeder;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    recipeRepo = RecipeRepositoryImpl(db);
    shoppingRepo = ShoppingRepositoryImpl(db: db, recipeRepo: recipeRepo);
    seeder = RecipeSeeder(db);
    await seeder.seedIfNeeded();
  });

  tearDown(() => db.close());

  group('ShoppingRepositoryImpl', () {
    test('başlangıçta plan ve liste boştur', () async {
      final plan = await shoppingRepo.watchPlan().first;
      final items = await shoppingRepo.watchItems().first;
      expect(plan, isEmpty);
      expect(items, isEmpty);
    });

    test('plana tarif eklenince alışveriş listesi otomatik hesaplanır', () async {
      final recipe = kInitialRecipes.first; // Creamy Garlic Chicken Pasta
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, 2);

      final plan = await shoppingRepo.watchPlan().first;
      expect(plan.length, 1);
      expect(plan.first.recipe.id, recipe.id);
      expect(plan.first.servings, 2);

      final items = await shoppingRepo.watchItems().first;
      expect(items, isNotEmpty);
      expect(items.any((i) => i.name.contains('chicken thighs')), isTrue);
    });

    test('malzemenin isChecked durumu güncellenir ve kalıcı olur', () async {
      final recipe = kInitialRecipes.first;
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, 2);

      var items = await shoppingRepo.watchItems().first;
      final firstItem = items.first;
      expect(firstItem.isChecked, isFalse);

      await shoppingRepo.toggleItemChecked(firstItem.id);

      items = await shoppingRepo.watchItems().first;
      final updatedItem = items.firstWhere((i) => i.id == firstItem.id);
      expect(updatedItem.isChecked, isTrue);
    });

    test('porsiyon güncellenince miktarlar artar ve isChecked durumu korunur', () async {
      final recipe = kInitialRecipes.first;
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, 2);

      var items = await shoppingRepo.watchItems().first;
      final chicken = items.firstWhere((i) => i.name.contains('chicken thighs'));
      expect(chicken.aggregatedAmount, 400.0);

      // Tavuğu aldık diye işaretle
      await shoppingRepo.setItemChecked(chicken.id, true);

      // Porsiyonu 2'den 4'e çıkar
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, 4);

      items = await shoppingRepo.watchItems().first;
      final updatedChicken = items.firstWhere((i) => i.name.contains('chicken thighs'));
      expect(updatedChicken.aggregatedAmount, 800.0);
      expect(updatedChicken.isChecked, isTrue, reason: 'Checked durumu korunmalıdır');
    });

    test('tarif plandan çıkarılınca liste güncellenir', () async {
      final r1 = kInitialRecipes[0];
      final r2 = kInitialRecipes[1];

      await shoppingRepo.addOrUpdateRecipeInPlan(r1.id, 2);
      await shoppingRepo.addOrUpdateRecipeInPlan(r2.id, 2);

      var plan = await shoppingRepo.watchPlan().first;
      expect(plan.length, 2);

      await shoppingRepo.removeRecipeFromPlan(r1.id);

      plan = await shoppingRepo.watchPlan().first;
      expect(plan.length, 1);
      expect(plan.first.recipe.id, r2.id);

      final items = await shoppingRepo.watchItems().first;
      expect(items.every((i) => i.sourceRecipeTitles.contains(r2.title)), isTrue);
    });

    test('clearPlan tüm planı ve alışveriş listesini temizler', () async {
      final recipe = kInitialRecipes.first;
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, 2);

      await shoppingRepo.clearPlan();

      final plan = await shoppingRepo.watchPlan().first;
      final items = await shoppingRepo.watchItems().first;
      expect(plan, isEmpty);
      expect(items, isEmpty);
    });
  });
}
