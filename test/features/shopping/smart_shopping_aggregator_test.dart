import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/macros.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_enums.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_ingredient.dart';
import 'package:mob_kitchen/features/shopping/domain/services/smart_shopping_aggregator.dart';

void main() {
  group('SmartShoppingAggregator', () {
    test('boş plan boş liste döner', () {
      final items = SmartShoppingAggregator.aggregate(planEntries: const []);
      expect(items, isEmpty);
    });

    test('ağırlık birimlerini (gram) matematiksel olarak birleştirir', () {
      const r1 = Recipe(
        id: 'test_1',
        title: 'Tavuklu Pilav',
        subtitle: 'sub',
        category: RecipeCategory.onePot,
        prepTimeMinutes: 5,
        cookTimeMinutes: 15,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 500, proteinG: 30, carbsG: 50, fatG: 10),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Kemiksiz tavuk but',
            amount: 200,
            unit: MeasurementUnit.gram,
            aisleCategory: AisleCategory.butcherDeli,
            buyingTip: 'But al, kurumaz',
          ),
        ],
        steps: [],
      );

      const r2 = Recipe(
        id: 'test_2',
        title: 'Tavuk Çorbası',
        subtitle: 'sub',
        category: RecipeCategory.quickDinner,
        prepTimeMinutes: 5,
        cookTimeMinutes: 15,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 400, proteinG: 25, carbsG: 30, fatG: 8),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Kemiksiz tavuk but',
            amount: 150,
            unit: MeasurementUnit.gram,
            aisleCategory: AisleCategory.butcherDeli,
            buyingTip: 'Taze pembe olanı seç',
            substituteOption: 'Tavuk göğsü',
          ),
        ],
        steps: [],
      );

      final items = SmartShoppingAggregator.aggregate(
        planEntries: const [
          ShoppingPlanEntry(recipe: r1, servings: 2),
          ShoppingPlanEntry(recipe: r2, servings: 2),
        ],
      );

      expect(items.length, 1);
      final chicken = items.first;
      expect(chicken.name, 'Kemiksiz tavuk but');
      expect(chicken.aggregatedAmount, 350.0);
      expect(chicken.unit, MeasurementUnit.gram);
      expect(chicken.aisleCategory, AisleCategory.butcherDeli);
      expect(chicken.sourceRecipeTitles, ['Tavuk Çorbası', 'Tavuklu Pilav']);
      expect(chicken.buyingTip, contains('But al, kurumaz'));
      expect(chicken.buyingTip, contains('Taze pembe olanı seç'));
      expect(chicken.substituteOption, 'Tavuk göğsü');
    });

    test('hacim birimlerini (yemek kaşığı + ml) mililitreye normalize edip toplar', () {
      const r1 = Recipe(
        id: 'test_oil_1',
        title: 'Salata',
        subtitle: 'sub',
        category: RecipeCategory.budget,
        prepTimeMinutes: 5,
        cookTimeMinutes: 0,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 200, proteinG: 2, carbsG: 5, fatG: 15),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Zeytinyağı',
            amount: 1, // 1 yemek kaşığı = 15 ml
            unit: MeasurementUnit.tablespoon,
            aisleCategory: AisleCategory.pantry,
          ),
        ],
        steps: [],
      );

      const r2 = Recipe(
        id: 'test_oil_2',
        title: 'Kızartma',
        subtitle: 'sub',
        category: RecipeCategory.budget,
        prepTimeMinutes: 5,
        cookTimeMinutes: 10,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 300, proteinG: 1, carbsG: 2, fatG: 25),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Zeytinyağı',
            amount: 50,
            unit: MeasurementUnit.milliliter,
            aisleCategory: AisleCategory.pantry,
          ),
        ],
        steps: [],
      );

      final items = SmartShoppingAggregator.aggregate(
        planEntries: const [
          ShoppingPlanEntry(recipe: r1, servings: 2),
          ShoppingPlanEntry(recipe: r2, servings: 2),
        ],
      );

      expect(items.length, 1);
      final oil = items.first;
      expect(oil.name, 'Zeytinyağı');
      expect(oil.aggregatedAmount, 65.0);
      expect(oil.unit, MeasurementUnit.milliliter);
      expect(oil.sourceRecipeTitles, ['Kızartma', 'Salata']);
    });

    test('porsiyon ölçeklemesini birleştirmeye doğru uygular', () {
      const r1 = Recipe(
        id: 'test_scale',
        title: 'Yumurtalı Ekmek',
        subtitle: 'sub',
        category: RecipeCategory.quickDinner,
        prepTimeMinutes: 2,
        cookTimeMinutes: 5,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 300, proteinG: 15, carbsG: 20, fatG: 10),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Yumurta',
            amount: 2,
            unit: MeasurementUnit.piece,
            aisleCategory: AisleCategory.dairy,
          ),
        ],
        steps: [],
      );

      // 2 kişilik tariften 4 kişilik plan yapıyoruz -> 4 adet yumurta
      final items = SmartShoppingAggregator.aggregate(
        planEntries: const [
          ShoppingPlanEntry(recipe: r1, servings: 4),
        ],
      );

      expect(items.first.aggregatedAmount, 4.0);
    });

    test('mevcut isChecked durumlarını id eşleşmesine göre korur', () {
      const r1 = Recipe(
        id: 'test_checked',
        title: 'Makarna',
        subtitle: 'sub',
        category: RecipeCategory.pasta,
        prepTimeMinutes: 5,
        cookTimeMinutes: 10,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 400, proteinG: 10, carbsG: 70, fatG: 5),
        tags: [],
        chefGoldenRules: ['Kural 1', 'Kural 2'],
        storageAndReheatingTip: 'tip',
        ingredients: [
          RecipeIngredient(
            name: 'Tuz',
            amount: 1,
            unit: MeasurementUnit.teaspoon,
            aisleCategory: AisleCategory.spices,
          ),
        ],
        steps: [],
      );

      final items = SmartShoppingAggregator.aggregate(
        planEntries: const [
          ShoppingPlanEntry(recipe: r1, servings: 2),
        ],
        existingCheckedStates: {'tuz_volume': true},
      );

      expect(items.first.isChecked, isTrue);
    });

    test('gerçek Mob tariflerinden karma bir planda reyon sırasına göre dizer', () {
      final r1 = kInitialRecipes[0]; // Creamy Garlic Chicken Pasta
      final r2 = kInitialRecipes[1]; // Carbonara

      final items = SmartShoppingAggregator.aggregate(
        planEntries: [
          ShoppingPlanEntry(recipe: r1, servings: 2),
          ShoppingPlanEntry(recipe: r2, servings: 2),
        ],
      );

      expect(items, isNotEmpty);

      // Reyon sıralaması kontrolü: ilk item'ların reyonu sonrakilerden küçük veya eşit olmalı
      for (var i = 0; i < items.length - 1; i++) {
        expect(
          items[i].aisleCategory.shoppingOrder,
          lessThanOrEqualTo(items[i + 1].aisleCategory.shoppingOrder),
        );
      }
    });

    test('parantez içi ve virgüllü hazırlık notu içeren aynı malzemeleri tek satırda birleştirir', () {
      const r1 = Recipe(
        id: 'norm_1',
        title: 'Tarif A',
        subtitle: 'sub',
        category: RecipeCategory.onePot,
        prepTimeMinutes: 5,
        cookTimeMinutes: 10,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 300, proteinG: 10, carbsG: 20, fatG: 10),
        tags: [],
        chefGoldenRules: [],
        storageAndReheatingTip: '',
        ingredients: [
          RecipeIngredient(
            name: 'Sarımsak (ezilmiş)',
            amount: 2,
            unit: MeasurementUnit.clove,
            aisleCategory: AisleCategory.produce,
          ),
        ],
        steps: [],
      );

      const r2 = Recipe(
        id: 'norm_2',
        title: 'Tarif B',
        subtitle: 'sub',
        category: RecipeCategory.onePot,
        prepTimeMinutes: 5,
        cookTimeMinutes: 10,
        baseServings: 2,
        difficulty: Difficulty.easy,
        macros: Macros(kcal: 300, proteinG: 10, carbsG: 20, fatG: 10),
        tags: [],
        chefGoldenRules: [],
        storageAndReheatingTip: '',
        ingredients: [
          RecipeIngredient(
            name: 'Sarımsak, ince kıyılmış',
            amount: 3,
            unit: MeasurementUnit.clove,
            aisleCategory: AisleCategory.produce,
          ),
        ],
        steps: [],
      );

      final items = SmartShoppingAggregator.aggregate(
        planEntries: const [
          ShoppingPlanEntry(recipe: r1, servings: 2),
          ShoppingPlanEntry(recipe: r2, servings: 2),
        ],
      );

      expect(items.length, equals(1));
      expect(items.first.name, equals('Sarımsak'));
      expect(items.first.aggregatedAmount, equals(5.0));
    });
  });
}
