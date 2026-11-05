import '../../../../core/domain/measurement_unit.dart';
import '../entities/macros.dart';
import '../entities/recipe.dart';
import '../entities/recipe_ingredient.dart';

/// Culinary portion scaler and amount formatter.
class PortionScaler {
  const PortionScaler._();

  /// Scales the amount according to serving ratio and rounds to culinary practice.
  static double scaleAmount(
    double baseAmount, {
    required int baseServings,
    required int targetServings,
    required MeasurementUnit unit,
  }) {
    if (baseServings <= 0 || targetServings <= 0 || baseAmount <= 0) {
      return baseAmount;
    }
    final ratio = targetServings / baseServings;
    final rawScaled = baseAmount * ratio;
    return roundCulinaryAmount(rawScaled, unit);
  }

  /// Mutfak tipi yuvarlama:
  /// - Gram: >= 50g için en yakın 5'e, 10-50g arası tam sayıya, <10g için 0.5 hassasiyetine.
  /// - Ml: >= 50ml için en yakın 5'e, <50ml için tam sayıya.
  /// - Kaşık / Bardak / Adet / Tutam / Dilim: 0.25 veya 0.33 hassasiyetine yakınsar.
  static double roundCulinaryAmount(double raw, MeasurementUnit unit) {
    if (raw <= 0) return 0;

    switch (unit) {
      case MeasurementUnit.gram:
        if (raw >= 50) {
          return (raw / 5).round() * 5.0;
        } else if (raw >= 10) {
          return raw.roundToDouble();
        } else {
          return (raw * 2).round() / 2.0;
        }

      case MeasurementUnit.milliliter:
        if (raw >= 50) {
          return (raw / 5).round() * 5.0;
        } else if (raw >= 10) {
          return raw.roundToDouble();
        } else {
          return (raw * 2).round() / 2.0;
        }

      case MeasurementUnit.cup:
      case MeasurementUnit.tablespoon:
      case MeasurementUnit.teaspoon:
      case MeasurementUnit.piece:
      case MeasurementUnit.clove:
      case MeasurementUnit.slice:
      case MeasurementUnit.bunch:
      case MeasurementUnit.pinch:
      case MeasurementUnit.pack:
      case MeasurementUnit.can:
        return _roundToFractionalStep(raw);
    }
  }

  /// 0.25 (çeyrek), 0.33 (üçte bir), 0.5 (yarım), 0.67 (üçte iki), 0.75 (üç çeyrek) basamakları.
  static double _roundToFractionalStep(double val) {
    final integerPart = val.floor();
    final frac = val - integerPart;

    if (frac < 0.125) return integerPart.toDouble();
    if (frac < 0.29) return integerPart + 0.25;
    if (frac < 0.42) return integerPart + 0.33;
    if (frac < 0.58) return integerPart + 0.5;
    if (frac < 0.71) return integerPart + 0.67;
    if (frac < 0.88) return integerPart + 0.75;
    return (integerPart + 1).toDouble();
  }

  /// Kullanıcı arayüzünde gösterilecek estetik miktar metni (`1/2`, `1 1/3`, `250` vb.).
  static String formatAmount(double amount, MeasurementUnit unit) {
    if (amount <= 0) return '0';

    // Gram ve ml için kesirsiz temiz tam sayı veya tek ondalık göster
    if (unit == MeasurementUnit.gram || unit == MeasurementUnit.milliliter) {
      if (amount == amount.roundToDouble()) {
        return amount.toInt().toString();
      }
      return amount.toStringAsFixed(1).replaceAll('.0', '');
    }

    final intPart = amount.floor();
    final frac = amount - intPart;

    String? fracStr;
    if ((frac - 0.25).abs() < 0.05) {
      fracStr = '1/4';
    } else if ((frac - 0.33).abs() < 0.06 || (frac - 0.333).abs() < 0.06) {
      fracStr = '1/3';
    } else if ((frac - 0.5).abs() < 0.05) {
      fracStr = '1/2';
    } else if ((frac - 0.67).abs() < 0.06 || (frac - 0.666).abs() < 0.06) {
      fracStr = '2/3';
    } else if ((frac - 0.75).abs() < 0.05) {
      fracStr = '3/4';
    }

    if (intPart == 0) {
      if (fracStr != null) return fracStr;
      return amount.toStringAsFixed(1).replaceAll('.0', '');
    } else {
      if (fracStr != null) return '$intPart $fracStr';
      if (frac < 0.05) return intPart.toString();
      return amount.toStringAsFixed(1).replaceAll('.0', '');
    }
  }

  /// Tek bir malzemeyi hedef porsiyona göre ölçekler.
  static RecipeIngredient scaleIngredient(
    RecipeIngredient ingredient, {
    required int baseServings,
    required int targetServings,
  }) {
    final scaled = scaleAmount(
      ingredient.amount,
      baseServings: baseServings,
      targetServings: targetServings,
      unit: ingredient.unit,
    );
    return ingredient.copyWith(amount: scaled);
  }

  /// Bir tarifi yeni hedef porsiyona göre ölçekler.
  /// Porsiyon başına makrolar sabit kalır; `baseServings` hedef porsiyonla güncellenir.
  static Recipe scaleRecipe(Recipe recipe, int targetServings) {
    if (recipe.baseServings == targetServings || targetServings <= 0) {
      return recipe;
    }
    final scaledIngredients = recipe.ingredients
        .map(
          (ing) => scaleIngredient(
            ing,
            baseServings: recipe.baseServings,
            targetServings: targetServings,
          ),
        )
        .toList(growable: false);

    return Recipe(
      id: recipe.id,
      title: recipe.title,
      subtitle: recipe.subtitle,
      category: recipe.category,
      prepTimeMinutes: recipe.prepTimeMinutes,
      cookTimeMinutes: recipe.cookTimeMinutes,
      baseServings: targetServings,
      difficulty: recipe.difficulty,
      macros: recipe.macros, // porsiyon başına makro değişmez
      tags: recipe.tags,
      chefGoldenRules: recipe.chefGoldenRules,
      storageAndReheatingTip: recipe.storageAndReheatingTip,
      ingredients: scaledIngredients,
      steps: recipe.steps,
      isBuiltIn: recipe.isBuiltIn,
      isFavorite: recipe.isFavorite,
      sourceRecipeId: recipe.sourceRecipeId,
      createdAt: recipe.createdAt,
    );
  }

  /// Tüm yemeğin toplam makro değerini hesaplar.
  static Macros calculateTotalMacros(Macros perServingMacros, int servings) {
    final safeServings = servings > 0 ? servings : 1;
    return Macros(
      kcal: perServingMacros.kcal * safeServings,
      proteinG: perServingMacros.proteinG * safeServings,
      carbsG: perServingMacros.carbsG * safeServings,
      fatG: perServingMacros.fatG * safeServings,
    );
  }
}
