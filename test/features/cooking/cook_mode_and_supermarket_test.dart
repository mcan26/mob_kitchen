import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/cooking/presentation/cook_mode_screen.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/macros.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_enums.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_ingredient.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_step.dart';
import 'package:mob_kitchen/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:mob_kitchen/features/recipes/providers/recipe_providers.dart';
import 'package:mob_kitchen/features/shopping/domain/entities/shopping_list_item.dart';
import 'package:mob_kitchen/features/shopping/domain/repositories/shopping_repository.dart';
import 'package:mob_kitchen/features/shopping/domain/services/smart_shopping_aggregator.dart';
import 'package:mob_kitchen/features/shopping/presentation/supermarket_screen.dart';
import 'package:mob_kitchen/features/shopping/providers/shopping_providers.dart';
import 'package:mob_kitchen/features/wireless/providers/wireless_providers.dart';

final testCookRecipe = Recipe(
  id: 'r_cook_test',
  title: 'Çıtır Tavuk Bowl',
  subtitle: 'Soya ballı glaze sos ile',
  category: RecipeCategory.crispyChicken,
  prepTimeMinutes: 10,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: const Macros(kcal: 600, proteinG: 45, carbsG: 40, fatG: 22),
  tags: const ['Tavuk', 'Çıtır'],
  chefGoldenRules: const ['Tavukları mısır nişastasına iki kez bula.'],
  storageAndReheatingTip: 'Hava alan kapta sakla.',
  ingredients: const [
    RecipeIngredient(
      name: 'Tavuk Kalça',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
    ),
  ],
  steps: const [
    RecipeStep(
      stepNumber: 1,
      title: 'Tavukları Kızartma',
      instruction: 'Kızgın yağda altın sarısı olana dek 6 dakika kızartın.',
      sensoryCue: 'Kabuk sertleşip çıtırdadığında ve maşayla vurunca ses verdiğinde.',
      chefTip: 'Tavaya bir anda çok tavuk atıp yağın ısısını düşürmeyin.',
      timerSeconds: 360,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sosu Bağlama',
      instruction: 'Tavada sos malzemelerini bir taşım kaynatıp tavukları içine atın.',
      sensoryCue: 'Sos parlak ve yapışkan kıvama geldiğinde.',
      chefTip: 'Ateşi kısıp 30 saniye hızlıca çevirin.',
    ),
  ],
  isBuiltIn: true,
  isFavorite: false,
);

class FakeRecipeRepo implements RecipeRepository {
  @override
  Stream<Recipe?> watchById(String id) => Stream.value(testCookRecipe);

  @override
  Stream<List<Recipe>> watchAll() => Stream.value([testCookRecipe]);

  @override
  Future<Recipe?> getById(String id) async => testCookRecipe;

  @override
  Future<void> save(Recipe recipe) async {}

  @override
  Future<void> toggleFavorite(String id) async {}

  @override
  Future<void> delete(String id) async {}
}

class FakeShoppingRepo implements ShoppingRepository {
  List<ShoppingListItem> items = [
    const ShoppingListItem(
      id: 'item_1',
      name: 'Tavuk Kalça',
      aggregatedAmount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      sourceRecipeTitles: ['Çıtır Tavuk Bowl'],
      buyingTip: 'Kemiksiz ve derisiz tercih edin.',
      substituteOption: 'Tavuk göğsü',
      isChecked: false,
    ),
    const ShoppingListItem(
      id: 'item_2',
      name: 'Taze Soğan',
      aggregatedAmount: 1,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      sourceRecipeTitles: ['Çıtır Tavuk Bowl'],
      isChecked: true,
    ),
  ];

  bool clearCheckedCalled = false;
  bool clearPlanCalled = false;
  String? toggledItemId;

  @override
  Stream<List<ShoppingListItem>> watchItems() => Stream.value(items);

  @override
  Stream<List<ShoppingPlanEntry>> watchPlan() => Stream.value([
        ShoppingPlanEntry(recipe: testCookRecipe, servings: 2),
      ]);

  @override
  Future<void> toggleItemChecked(String itemId) async {
    toggledItemId = itemId;
  }

  @override
  Future<void> clearCheckedItems() async {
    clearCheckedCalled = true;
  }

  @override
  Future<void> clearPlan() async {
    clearPlanCalled = true;
  }

  @override
  Future<void> addOrUpdateRecipeInPlan(String recipeId, int servings) async {}

  @override
  Future<void> removeRecipeFromPlan(String recipeId) async {}

  @override
  Future<void> setItemChecked(String itemId, bool isChecked) async {}
}

void main() {
  group('CookModeScreen Widget Tests', () {
    testWidgets('adım talimatı, duyusal işaretler ve adımlar arası geçiş çalışır', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeByIdProvider('r_cook_test').overrideWith((ref) => Stream.value(testCookRecipe)),
          ],
          child: const MaterialApp(
            home: CookModeScreen(recipeId: 'r_cook_test'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Adım Başlığı ve Talimatı
      expect(find.text('Tavukları Kızartma'), findsOneWidget);
      expect(find.text('Step 1 / 2'), findsOneWidget);
      expect(find.textContaining('6 dakika kızartın'), findsOneWidget);
      expect(find.textContaining('Kabuk sertleşip çıtırdadığında'), findsOneWidget);

      // Adım İçi Malzeme Göstergesi
      expect(find.text('INGREDIENTS FOR THIS STEP:'), findsOneWidget);
      expect(find.text('Tavuk Kalça'), findsOneWidget);
      expect(find.text('400 g'), findsOneWidget);

      // Sayaç Butonu görünür (360 saniye = 6 dk)
      expect(find.textContaining('Start Timer (6 Minutes)'), findsOneWidget);

      // Sayacı Başlat
      await tester.tap(find.textContaining('Start Timer (6 Minutes)'));
      await tester.pumpAndSettle();

      // Sayaç çalışmaya başladı
      expect(find.text('Timer Counting Down...'), findsOneWidget);

      // Sonraki Adıma Geç
      await tester.tap(find.text('Next Step'));
      await tester.pumpAndSettle();

      // 2. Adıma geçtiğini doğrula
      expect(find.text('Sosu Bağlama'), findsOneWidget);
      expect(find.text('Step 2 / 2'), findsOneWidget);

      // Bitir Butonunun geldiğini doğrula
      expect(find.text('Finish 🎉'), findsOneWidget);
    });

    testWidgets('targetServings verildiğinde adım içi malzeme miktarlarını porsiyona göre ölçekler', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeByIdProvider('r_cook_test').overrideWith((ref) => Stream.value(testCookRecipe)),
          ],
          child: const MaterialApp(
            // 2 kişilik tarif (400g Tavuk Kalça) -> 4 kişilik (800g) olarak açılıyor
            home: CookModeScreen(recipeId: 'r_cook_test', targetServings: 4),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Tavuk Kalça'), findsOneWidget);
      expect(find.text('800 g'), findsOneWidget);
    });

    testWidgets('uzak eş telefondan cook_step_sync paketi geldiğinde CookModeScreen adımını otomatik senkronize eder ve geri yankı (echo) yapmaz', (tester) async {
      final container = ProviderContainer(
        overrides: [
          recipeByIdProvider('r_cook_test').overrideWith((ref) => Stream.value(testCookRecipe)),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: CookModeScreen(recipeId: 'r_cook_test'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Step 1 / 2'), findsOneWidget);
      expect(find.text('Tavukları Kızartma'), findsOneWidget);

      await container.read(smartKitchenHubProvider.notifier).processIncomingPacket({
        'type': 'cook_step_sync',
        'sender': 'Sous-Chef iPhone',
        'recipeId': 'r_cook_test',
        'stepIndex': 2,
        'totalSteps': 2,
      });
      await tester.pumpAndSettle();

      // CookModeScreen otomatik olarak 2. adıma geçmeli
      expect(find.text('Step 2 / 2'), findsOneWidget);
      expect(find.text('Sosu Bağlama'), findsOneWidget);
      // Geri yankı (echo) yapılmadığı için syncEvents içinde yalnızca gelen 1 olay olmalı
      expect(container.read(smartKitchenHubProvider).syncEvents.length, 1);
    });
  });

  group('SupermarketScreen Widget Tests', () {
    testWidgets('reyon grupları, malzeme listesi ve işaretleme aksiyonları çalışır', (tester) async {
      final fakeShopping = FakeShoppingRepo();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            shoppingRepositoryProvider.overrideWithValue(fakeShopping),
            shoppingListItemsProvider.overrideWith((ref) => Stream.value(fakeShopping.items)),
            shoppingPlanProvider.overrideWith((ref) => fakeShopping.watchPlan()),
          ],
          child: const MaterialApp(
            home: SupermarketScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Başlık ve İlerleme
      expect(find.text('Supermarket Mode'), findsOneWidget);
      expect(find.text('1 / 2 Items in Cart'), findsOneWidget);

      // Reyonlar (Manav ve Kasap)
      expect(find.text('Produce & Herbs'), findsOneWidget);
      expect(find.text('Butcher & Deli'), findsOneWidget);

      // Malzemeler
      expect(find.text('Tavuk Kalça'), findsOneWidget);
      expect(find.text('400 g'), findsOneWidget);
      expect(find.text('Taze Soğan'), findsOneWidget);
      expect(find.text('1 bunch'), findsOneWidget);

      // Market tüyosu görünürlüğü
      expect(find.text('Kemiksiz ve derisiz tercih edin.'), findsOneWidget);
      expect(find.text('Substitute: Tavuk göğsü'), findsOneWidget);

      // Tavuk Kalça satırına tıkla (işaretleme tetikle)
      await tester.tap(find.text('Tavuk Kalça'));
      await tester.pumpAndSettle();

      expect(fakeShopping.toggledItemId, equals('item_1'));

      // Reyon Daraltma Testi (Manav reyonuna tıkla ve kapat)
      await tester.tap(find.text('Produce & Herbs'));
      await tester.pumpAndSettle();

      // Taze Soğan artık kapalı olduğu için ekranda olmamalı
      expect(find.text('Taze Soğan'), findsNothing);

      // Manav reyonuna tekrar tıkla ve aç
      await tester.tap(find.text('Produce & Herbs'));
      await tester.pumpAndSettle();

      // Taze Soğan tekrar görünür olmalı
      expect(find.text('Taze Soğan'), findsOneWidget);
    });
  });
}
