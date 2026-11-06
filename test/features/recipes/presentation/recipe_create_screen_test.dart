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
import 'package:mob_kitchen/features/recipes/presentation/recipe_create_screen.dart';
import 'package:mob_kitchen/features/recipes/providers/recipe_providers.dart';

class _FakeRecipeRepo implements RecipeRepository {
  Recipe? savedRecipe;
  String? deletedId;

  @override
  Stream<List<Recipe>> watchAll() => Stream.value(savedRecipe != null ? [savedRecipe!] : []);

  @override
  Stream<Recipe?> watchById(String id) => Stream.value(savedRecipe);

  @override
  Future<Recipe?> getById(String id) async => savedRecipe;

  @override
  Future<void> save(Recipe recipe) async {
    savedRecipe = recipe;
  }

  @override
  Future<void> toggleFavorite(String id) async {}

  @override
  Future<void> delete(String id) async {
    deletedId = id;
  }
}

void main() {
  late _FakeRecipeRepo fakeRepo;

  setUp(() {
    fakeRepo = _FakeRecipeRepo();
  });

  group('RecipeCreateScreen Widget Tests', () {
    testWidgets('renders all basic sections, adds ingredients and saves custom recipe', (tester) async {
      tester.view.physicalSize = const Size(1000, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: const MaterialApp(
            home: RecipeCreateScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Form sections exist
      expect(find.text('Create Custom Recipe'), findsOneWidget);
      expect(find.text('1. Recipe Overview'), findsOneWidget);
      expect(find.text('2. Nutrition per Serving (Macros)'), findsOneWidget);
      expect(find.text('3. Ingredients'), findsOneWidget);
      expect(find.text('4. Step-by-Step Instructions'), findsOneWidget);

      // Enter title and subtitle
      final titleField = find.widgetWithText(TextFormField, 'Recipe Title *');
      await tester.enterText(titleField, 'Artisanal Garlic Parmesan Gnocchi');

      final subtitleField = find.widgetWithText(TextFormField, 'Editorial Subtitle / Hook *');
      await tester.enterText(subtitleField, 'Crisp on the outside, pillow-soft inside in rich browned butter.');

      await tester.pumpAndSettle();

      // Tap Save button
      final saveButton = find.text('Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify that repository.save was called with correct entity values
      expect(fakeRepo.savedRecipe, isNotNull);
      final saved = fakeRepo.savedRecipe!;
      expect(saved.title, equals('Artisanal Garlic Parmesan Gnocchi'));
      expect(saved.subtitle, equals('Crisp on the outside, pillow-soft inside in rich browned butter.'));
      expect(saved.isBuiltIn, isFalse);
      expect(saved.ingredients.length, greaterThanOrEqualTo(1));
      expect(saved.steps.length, greaterThanOrEqualTo(1));
    });

    testWidgets('editing an existing recipe pre-populates fields properly', (tester) async {
      final existingRecipe = Recipe(
        id: 'user_recipe_test_1',
        title: 'Existing Custom Burger',
        subtitle: 'Juicy double patty burger',
        category: RecipeCategory.budget,
        prepTimeMinutes: 12,
        cookTimeMinutes: 18,
        baseServings: 4,
        difficulty: Difficulty.easy,
        macros: const Macros(kcal: 750, proteinG: 45, carbsG: 50, fatG: 30),
        tags: const ['Burger', 'Dinner'],
        chefGoldenRules: const ['Smash thinly on high heat.'],
        storageAndReheatingTip: 'Consume fresh.',
        ingredients: const [
          RecipeIngredient(
            name: 'Beef Patty',
            amount: 2,
            unit: MeasurementUnit.piece,
            aisleCategory: AisleCategory.butcherDeli,
          ),
        ],
        steps: const [
          RecipeStep(
            stepNumber: 1,
            title: 'Sear Patties',
            instruction: 'Sear on a screaming hot griddle.',
            sensoryCue: 'Crispy edges form in 2 minutes.',
            chefTip: 'Do not flip prematurely.',
            timerSeconds: 120,
          ),
        ],
        isBuiltIn: false,
      );

      fakeRepo.savedRecipe = existingRecipe;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            recipeRepositoryProvider.overrideWithValue(fakeRepo),
            recipeByIdProvider('user_recipe_test_1').overrideWith((ref) => Stream.value(existingRecipe)),
          ],
          child: const MaterialApp(
            home: RecipeCreateScreen(editRecipeId: 'user_recipe_test_1'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify pre-populated title and mode
      expect(find.text('Edit Custom Recipe'), findsOneWidget);
      expect(find.text('Existing Custom Burger'), findsOneWidget);
      expect(find.text('Juicy double patty burger'), findsOneWidget);
    });
  });
}
