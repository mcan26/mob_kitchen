import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';
import '../../domain/entities/macros.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_enums.dart';
import '../../domain/entities/recipe_ingredient.dart';
import '../../domain/entities/recipe_step.dart';

/// Drift satırları ↔ domain entity dönüşümleri.
class RecipeMapper {
  const RecipeMapper._();

  static Recipe toEntity(
    RecipeRow row,
    List<RecipeIngredientRow> ingredientRows,
    List<RecipeStepRow> stepRows,
  ) {
    final ingredients = [...ingredientRows]..sort((a, b) => a.position.compareTo(b.position));
    final steps = [...stepRows]..sort((a, b) => a.stepNumber.compareTo(b.stepNumber));

    return Recipe(
      id: row.id,
      title: row.title,
      subtitle: row.subtitle,
      category: RecipeCategory.fromJson(row.category),
      prepTimeMinutes: row.prepTimeMinutes,
      cookTimeMinutes: row.cookTimeMinutes,
      baseServings: row.baseServings,
      difficulty: Difficulty.fromJson(row.difficulty),
      macros: Macros(
        kcal: row.kcal,
        proteinG: row.proteinG,
        carbsG: row.carbsG,
        fatG: row.fatG,
      ),
      tags: row.tags,
      chefGoldenRules: row.chefGoldenRules,
      storageAndReheatingTip: row.storageAndReheatingTip,
      ingredients: ingredients
          .map((r) => RecipeIngredient(
                name: r.name,
                amount: r.amount,
                unit: MeasurementUnit.fromJson(r.unit),
                aisleCategory: AisleCategory.fromJson(r.aisleCategory),
                preparationNote: r.preparationNote,
                buyingTip: r.buyingTip,
                substituteOption: r.substituteOption,
              ))
          .toList(growable: false),
      steps: steps
          .map((r) => RecipeStep(
                stepNumber: r.stepNumber,
                title: r.title,
                instruction: r.instruction,
                sensoryCue: r.sensoryCue,
                chefTip: r.chefTip,
                timerSeconds: r.timerSeconds,
                mistakeWarning: r.mistakeWarning,
              ))
          .toList(growable: false),
      isBuiltIn: row.isBuiltIn,
      isFavorite: row.isFavorite,
      sourceRecipeId: row.sourceRecipeId,
      createdAt: row.createdAt,
    );
  }

  static RecipesCompanion toRecipeCompanion(Recipe r) => RecipesCompanion.insert(
        id: r.id,
        title: r.title,
        subtitle: r.subtitle,
        category: r.category.jsonValue,
        prepTimeMinutes: r.prepTimeMinutes,
        cookTimeMinutes: r.cookTimeMinutes,
        baseServings: r.baseServings,
        difficulty: r.difficulty.jsonValue,
        kcal: r.macros.kcal,
        proteinG: r.macros.proteinG,
        carbsG: r.macros.carbsG,
        fatG: r.macros.fatG,
        tags: r.tags,
        chefGoldenRules: r.chefGoldenRules,
        storageAndReheatingTip: r.storageAndReheatingTip,
        isBuiltIn: Value(r.isBuiltIn),
        isFavorite: Value(r.isFavorite),
        sourceRecipeId: Value(r.sourceRecipeId),
        createdAt: Value(r.createdAt ?? DateTime.now()),
      );

  static List<RecipeIngredientsCompanion> toIngredientCompanions(Recipe r) => [
        for (final (i, ing) in r.ingredients.indexed)
          RecipeIngredientsCompanion.insert(
            recipeId: r.id,
            position: i,
            name: ing.name,
            amount: ing.amount,
            unit: ing.unit.jsonValue,
            aisleCategory: ing.aisleCategory.jsonValue,
            preparationNote: Value(ing.preparationNote),
            buyingTip: Value(ing.buyingTip),
            substituteOption: Value(ing.substituteOption),
          ),
      ];

  static List<RecipeStepsCompanion> toStepCompanions(Recipe r) => [
        for (final s in r.steps)
          RecipeStepsCompanion.insert(
            recipeId: r.id,
            stepNumber: s.stepNumber,
            title: s.title,
            instruction: s.instruction,
            sensoryCue: s.sensoryCue,
            chefTip: s.chefTip,
            timerSeconds: Value(s.timerSeconds),
            mistakeWarning: Value(s.mistakeWarning),
          ),
      ];
}
