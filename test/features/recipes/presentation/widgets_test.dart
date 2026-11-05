import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/macros.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_enums.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_ingredient.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_step.dart';
import 'package:mob_kitchen/features/recipes/presentation/widgets/golden_rules_card.dart';
import 'package:mob_kitchen/features/recipes/presentation/widgets/ingredient_tile.dart';
import 'package:mob_kitchen/features/recipes/presentation/widgets/portion_selector_bar.dart';
import 'package:mob_kitchen/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:mob_kitchen/features/recipes/presentation/widgets/step_tile.dart';

void main() {
  final sampleRecipe = Recipe(
    id: 'test_recipe_1',
    title: 'Test Spagetti Carbonara',
    subtitle: 'Kremasız, sadece yumurta sarısı ve pecorino ile',
    category: RecipeCategory.pasta,
    prepTimeMinutes: 10,
    cookTimeMinutes: 15,
    baseServings: 2,
    difficulty: Difficulty.medium,
    macros: const Macros(kcal: 650, proteinG: 32, carbsG: 68, fatG: 24),
    tags: const ['Makarna', 'İtalyan', 'Kremasız'],
    chefGoldenRules: const [
      'Asla krema ekleme.',
      'Yumurta sosunu ocak kapalıyken tavanın artık ısısıyla bağla.',
    ],
    storageAndReheatingTip: 'Taze tüketilmesi önerilir.',
    ingredients: const [
      RecipeIngredient(
        name: 'Guanciale',
        amount: 150,
        unit: MeasurementUnit.gram,
        aisleCategory: AisleCategory.butcherDeli,
        buyingTip: 'Bulamazsan yağlı dana döş veya füme antrikot kullan.',
        substituteOption: 'Pancetta',
      ),
      RecipeIngredient(
        name: 'Yumurta Sarısı',
        amount: 4,
        unit: MeasurementUnit.piece,
        aisleCategory: AisleCategory.dairy,
      ),
    ],
    steps: const [
      RecipeStep(
        stepNumber: 1,
        title: 'Guanciale Çıtırdatma',
        instruction: 'Soğuk tavaya alıp kısık ateşte yağını salana kadar pişirin.',
        sensoryCue: 'Kenarları altın sarısı ve çıtır olunca ocaktan alın.',
        chefTip: 'Tavaya ekstra yağ eklemeyin, kendi yağı yetecektir.',
        timerSeconds: 300,
      ),
    ],
    isBuiltIn: true,
    isFavorite: false,
  );

  group('RecipeCard Widget Tests', () {
    testWidgets('başlık, kategori, süre, makro ve etiketleri render eder', (tester) async {
      var tapped = false;
      var favoriteToggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecipeCard(
              recipe: sampleRecipe,
              onTap: () => tapped = true,
              onFavoriteToggle: () => favoriteToggled = true,
            ),
          ),
        ),
      );

      expect(find.text('Test Spagetti Carbonara'), findsOneWidget);
      expect(find.text(sampleRecipe.subtitle), findsOneWidget);
      expect(find.text('25 min'), findsOneWidget);
      expect(find.text('2 Servings'), findsOneWidget);
      expect(find.text('Pasta'), findsOneWidget);
      expect(find.text('650 kcal'), findsOneWidget);
      expect(find.text('32g protein'), findsOneWidget);
      expect(find.text('#Makarna'), findsOneWidget);

      // Tıklama testi
      await tester.tap(find.text('Test Spagetti Carbonara'));
      expect(tapped, isTrue);

      // Favori butonu testi
      await tester.tap(find.byIcon(Icons.favorite_border));
      expect(favoriteToggled, isTrue);
    });
  });

  group('PortionSelectorBar Widget Tests', () {
    testWidgets('hızlı seçenek butonları ve +/- butonları doğru çalışır', (tester) async {
      int? currentVal;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PortionSelectorBar(
              currentServings: 2,
              onChanged: (newVal) => currentVal = newVal,
            ),
          ),
        ),
      );

      expect(find.text('Servings:'), findsOneWidget);
      expect(find.text('2'), findsNWidgets(2)); // Biri buton diğeri sayaç ortası

      // 4 porsiyon hızlı butonuna dokun
      await tester.tap(find.text('4'));
      expect(currentVal, equals(4));

      // 1 porsiyon hızlı butonuna dokun
      await tester.tap(find.text('1'));
      expect(currentVal, equals(1));

      // Artı butonuna dokun
      await tester.tap(find.byIcon(Icons.add));
      expect(currentVal, equals(3));

      // Eksi butonuna dokun
      await tester.tap(find.byIcon(Icons.remove));
      expect(currentVal, equals(1));
    });
  });

  group('IngredientTile Widget Tests', () {
    testWidgets('porsiyon ölçeklemesi ve market tüyosu akordiyonu çalışır', (tester) async {
      final ing = sampleRecipe.ingredients.first; // 150g Guanciale (2 kişilikte)

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientTile(
              ingredient: ing,
              originalServings: 2,
              targetServings: 4, // 2 katına çıkar: 300g olmalı
            ),
          ),
        ),
      );

      expect(find.text('Guanciale'), findsOneWidget);
      expect(find.text('300 g'), findsOneWidget);

      // Market tüyosu başlangıçta kapalı
      expect(find.text('Shopping Tip: '), findsNothing);

      // Karta dokunup genişlet
      await tester.tap(find.text('Guanciale'));
      await tester.pumpAndSettle();

      expect(find.text('Shopping Tip: '), findsOneWidget);
      expect(find.text('Swap: '), findsOneWidget);
      expect(find.text('Bulamazsan yağlı dana döş veya füme antrikot kullan.'), findsOneWidget);
      expect(find.text('Pancetta'), findsOneWidget);
    });
  });

  group('GoldenRulesCard & StepTile Widget Tests', () {
    testWidgets('altın kuralları doğru listeler', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GoldenRulesCard(rules: sampleRecipe.chefGoldenRules),
          ),
        ),
      );

      expect(find.text("Chef's Golden Rules"), findsOneWidget);
      expect(find.text('Asla krema ekleme.'), findsOneWidget);
      expect(find.text('Yumurta sosunu ocak kapalıyken tavanın artık ısısıyla bağla.'), findsOneWidget);
    });

    testWidgets('adım kartı talimat, duyusal işaret, şef sırrı ve sayacı gösterir', (tester) async {
      final step = sampleRecipe.steps.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StepTile(step: step),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('Guanciale Çıtırdatma'), findsOneWidget);
      expect(find.text(step.instruction), findsOneWidget);
      expect(find.textContaining('Kenarları altın sarısı ve çıtır'), findsOneWidget);
      expect(find.textContaining('Tavaya ekstra yağ eklemeyin'), findsOneWidget);
      expect(find.text('5 min'), findsOneWidget); // 300 saniye = 5 dk
    });
  });
}
