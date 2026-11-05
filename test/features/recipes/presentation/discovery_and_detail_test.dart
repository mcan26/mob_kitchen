import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/macros.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_enums.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_ingredient.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_step.dart';
import 'package:mob_kitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:mob_kitchen/features/recipes/presentation/discovery_feed_screen.dart';
import 'package:mob_kitchen/features/recipes/presentation/recipe_detail_screen.dart';
import 'package:mob_kitchen/features/recipes/providers/recipe_providers.dart';
import 'package:mob_kitchen/features/shopping/domain/entities/shopping_list_item.dart';
import 'package:mob_kitchen/features/shopping/domain/repositories/shopping_repository.dart';
import 'package:mob_kitchen/features/shopping/domain/services/smart_shopping_aggregator.dart';
import 'package:mob_kitchen/features/shopping/providers/shopping_providers.dart';

final mockRecipe1 = Recipe(
  id: 'r_onepot',
  title: 'Tek Tava Kremalı Tavuk',
  subtitle: '20 dakikada tek tavada nefis lezzet',
  category: RecipeCategory.onePot,
  prepTimeMinutes: 5,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: const Macros(kcal: 550, proteinG: 40, carbsG: 20, fatG: 25),
  tags: const ['Tavuk', 'Tek Tava', 'Hızlı'],
  chefGoldenRules: const ['Tavuğu çok doldurma.'],
  storageAndReheatingTip: 'Buzdolabında 2 gün saklanabilir.',
  ingredients: const [
    RecipeIngredient(
      name: 'Tavuk Göğsü',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
    ),
  ],
  steps: const [
    RecipeStep(
      stepNumber: 1,
      title: 'Tavuk Mühürleme',
      instruction: 'Tavukları yüksek ateşte soteleyin.',
      sensoryCue: 'Dışı altın rengi olunca.',
      chefTip: 'Tavayı iyice ısıtın.',
    ),
  ],
  isBuiltIn: true,
  isFavorite: true,
);

final mockRecipe2 = Recipe(
  id: 'r_pasta',
  title: 'Klasik Spagetti Carbonara',
  subtitle: 'Guanciale ve pecorino ile',
  category: RecipeCategory.pasta,
  prepTimeMinutes: 10,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: const Macros(kcal: 650, proteinG: 28, carbsG: 70, fatG: 26),
  tags: const ['Makarna'],
  chefGoldenRules: const ['Krema yok.'],
  storageAndReheatingTip: 'Taze tüketin.',
  ingredients: const [
    RecipeIngredient(
      name: 'Guanciale',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
    ),
  ],
  steps: const [
    RecipeStep(
      stepNumber: 1,
      title: 'Pişirme',
      instruction: 'Makarnayı haşlayın.',
      sensoryCue: 'Al dente olunca.',
      chefTip: 'Makarna suyunu saklayın.',
    ),
  ],
  isBuiltIn: true,
  isFavorite: false,
);

class FakeRecipeRepository implements RecipeRepository {
  final List<Recipe> recipes = [mockRecipe1, mockRecipe2];

  @override
  Stream<List<Recipe>> watchAll() => Stream.value(recipes);

  @override
  Stream<Recipe?> watchById(String id) {
    final r = recipes.where((e) => e.id == id).firstOrNull;
    return Stream.value(r);
  }

  @override
  Future<Recipe?> getById(String id) async => recipes.where((e) => e.id == id).firstOrNull;

  @override
  Future<void> save(Recipe recipe) async {}

  @override
  Future<void> toggleFavorite(String id) async {}

  @override
  Future<void> delete(String id) async {}
}

class FakeShoppingRepository implements ShoppingRepository {
  String? lastAddedRecipeId;
  int? lastAddedServings;

  @override
  Future<void> addOrUpdateRecipeInPlan(String recipeId, int servings) async {
    lastAddedRecipeId = recipeId;
    lastAddedServings = servings;
  }

  @override
  Future<void> clearCheckedItems() async {}

  @override
  Future<void> clearPlan() async {}

  @override
  Future<void> removeRecipeFromPlan(String recipeId) async {}

  @override
  Future<void> setItemChecked(String itemId, bool isChecked) async {}

  @override
  Future<void> toggleItemChecked(String itemId) async {}

  @override
  Stream<List<ShoppingListItem>> watchItems() => Stream.value([]);

  @override
  Stream<List<ShoppingPlanEntry>> watchPlan() => Stream.value([]);
}

void main() {
  late FakeRecipeRepository fakeRecipeRepo;
  late FakeShoppingRepository fakeShoppingRepo;

  setUp(() {
    fakeRecipeRepo = FakeRecipeRepository();
    fakeShoppingRepo = FakeShoppingRepository();
  });

  group('DiscoveryFeedScreen Tests', () {
    testWidgets('tüm tarifleri listeler, arama çubuğu ve filtre çipleri çalışır', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeRepositoryProvider.overrideWithValue(fakeRecipeRepo),
            allRecipesProvider.overrideWith((ref) => Stream.value([mockRecipe1, mockRecipe2])),
          ],
          child: const MaterialApp(
            home: DiscoveryFeedScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Başlangıçta 2 tarif de görünür
      expect(find.text('Tek Tava Kremalı Tavuk'), findsOneWidget);
      expect(find.text('Klasik Spagetti Carbonara'), findsOneWidget);

      // Arama çubuğuna "Guanciale" yaz
      await tester.enterText(find.byType(TextField), 'Guanciale');
      await tester.pumpAndSettle();

      // Sadece Carbonara kalmalı
      expect(find.text('Tek Tava Kremalı Tavuk'), findsNothing);
      expect(find.text('Klasik Spagetti Carbonara'), findsOneWidget);

      // Arama metnini temizle
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Tek Tava Kremalı Tavuk'), findsOneWidget);
      expect(find.text('Klasik Spagetti Carbonara'), findsOneWidget);

      // "One-Pan" filtre çipine dokun
      await tester.tap(find.text('One-Pan').first);
      await tester.pumpAndSettle();

      // Sadece Tek Tava kalmalı
      expect(find.text('Tek Tava Kremalı Tavuk'), findsOneWidget);
      expect(find.text('Klasik Spagetti Carbonara'), findsNothing);
    });
  });

  group('RecipeDetailScreen Tests', () {
    testWidgets('tarif detayını, altın kuralları ve dinamik porsiyon ölçeklemeyi gösterir', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeRepositoryProvider.overrideWithValue(fakeRecipeRepo),
            recipeByIdProvider('r_onepot').overrideWith((ref) => Stream.value(mockRecipe1)),
            shoppingRepositoryProvider.overrideWithValue(fakeShoppingRepo),
          ],
          child: const MaterialApp(
            home: RecipeDetailScreen(recipeId: 'r_onepot'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Başlık & Alt başlık
      expect(find.text('Tek Tava Kremalı Tavuk'), findsOneWidget);
      expect(find.text('20 dakikada tek tavada nefis lezzet'), findsOneWidget);

      // Altın Kurallar
      expect(find.text("Chef's Golden Rules"), findsOneWidget);
      expect(find.text('Tavuğu çok doldurma.'), findsOneWidget);

      // 2 kişilikte 400g Tavuk Göğsü
      expect(find.text('Tavuk Göğsü'), findsOneWidget);
      expect(find.text('400 g'), findsOneWidget);

      // Porsiyonu 4'e çıkar
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      // 4 kişilikte 800g olmalı!
      expect(find.text('800 g'), findsOneWidget);

      // Alışveriş Listesine Ekle butonuna tıkla
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pumpAndSettle();

      expect(fakeShoppingRepo.lastAddedRecipeId, equals('r_onepot'));
      expect(fakeShoppingRepo.lastAddedServings, equals(4));

      // SnackBar doğrulama
      expect(find.textContaining('added to your shopping list!'), findsOneWidget);
    });
  });
}
