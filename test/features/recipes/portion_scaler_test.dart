import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_ingredient.dart';
import 'package:mob_kitchen/features/recipes/domain/services/portion_scaler.dart';

void main() {
  group('PortionScaler', () {
    test('ölçekleme oranı 1 ise miktar değişmez', () {
      final scaled = PortionScaler.scaleAmount(
        200,
        baseServings: 2,
        targetServings: 2,
        unit: MeasurementUnit.gram,
      );
      expect(scaled, 200.0);
    });

    test('gram miktarlarını 5 veya 10 katlarına temiz yuvarlar', () {
      // 400g (2 kişilik) -> 3 kişilik için 600g
      final s1 = PortionScaler.scaleAmount(
        400,
        baseServings: 2,
        targetServings: 3,
        unit: MeasurementUnit.gram,
      );
      expect(s1, 600.0);

      // 150g (2 kişilik) -> 1 kişilik için 75g
      final s2 = PortionScaler.scaleAmount(
        150,
        baseServings: 2,
        targetServings: 1,
        unit: MeasurementUnit.gram,
      );
      expect(s2, 75.0);
    });

    test('hacim ve kaşık birimlerini mutfak kesirlerine yuvarlar', () {
      // 1 yemek kaşığı (2 kişilik) -> 3 kişilik için 1.5 yemek kaşığı
      final s1 = PortionScaler.scaleAmount(
        1,
        baseServings: 2,
        targetServings: 3,
        unit: MeasurementUnit.tablespoon,
      );
      expect(s1, 1.5);

      // 1 çay kaşığı (2 kişilik) -> 1 kişilik için 0.5 çay kaşığı
      final s2 = PortionScaler.scaleAmount(
        1,
        baseServings: 2,
        targetServings: 1,
        unit: MeasurementUnit.teaspoon,
      );
      expect(s2, 0.5);
    });

    test('formatAmount: mutfak kesirlerini (1/2, 1 1/3, 3/4) estetik metne çevirir', () {
      expect(PortionScaler.formatAmount(0.5, MeasurementUnit.tablespoon), '1/2');
      expect(PortionScaler.formatAmount(0.25, MeasurementUnit.teaspoon), '1/4');
      expect(PortionScaler.formatAmount(0.33, MeasurementUnit.cup), '1/3');
      expect(PortionScaler.formatAmount(0.75, MeasurementUnit.cup), '3/4');
      expect(PortionScaler.formatAmount(1.5, MeasurementUnit.tablespoon), '1 1/2');
      expect(PortionScaler.formatAmount(2.33, MeasurementUnit.piece), '2 1/3');
      expect(PortionScaler.formatAmount(300, MeasurementUnit.gram), '300');
      expect(PortionScaler.formatAmount(150.0, MeasurementUnit.milliliter), '150');
    });

    test('scaleIngredient: malzemeyi hedef porsiyona göre ölçekler', () {
      const ing = RecipeIngredient(
        name: 'Kemiksiz tavuk but',
        amount: 400,
        unit: MeasurementUnit.gram,
        aisleCategory: AisleCategory.butcherDeli,
      );

      final scaled = PortionScaler.scaleIngredient(
        ing,
        baseServings: 2,
        targetServings: 4,
      );

      expect(scaled.amount, 800.0);
      expect(scaled.name, ing.name);
      expect(scaled.unit, ing.unit);
    });

    test('scaleRecipe: tüm tarifi ve malzemelerini ölçekler, porsiyon güncellenir', () {
      final baseRecipe = kInitialRecipes.first; // 2 kişilik
      final scaled = PortionScaler.scaleRecipe(baseRecipe, 4);

      expect(scaled.baseServings, 4);
      expect(scaled.ingredients.length, baseRecipe.ingredients.length);

      // İlk malzeme 400g idi, 4 kişilikte 800g olmalı
      expect(scaled.ingredients.first.amount, 800.0);

      // Porsiyon başına makro değişmez
      expect(scaled.macros, baseRecipe.macros);
    });

    test('calculateTotalMacros: porsiyona göre toplam makroyu çarpar', () {
      final baseRecipe = kInitialRecipes.first;
      final total = PortionScaler.calculateTotalMacros(baseRecipe.macros, 3);

      expect(total.kcal, baseRecipe.macros.kcal * 3);
      expect(total.proteinG, baseRecipe.macros.proteinG * 3);
      expect(total.carbsG, baseRecipe.macros.carbsG * 3);
      expect(total.fatG, baseRecipe.macros.fatG * 3);
    });
  });
}
