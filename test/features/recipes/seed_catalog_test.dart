import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';

void main() {
  group('Mob Classics seed kataloğu', () {
    test('en az 10 tarif içerir ve id\'ler benzersizdir', () {
      expect(kInitialRecipes.length, greaterThanOrEqualTo(10));
      final ids = kInitialRecipes.map((r) => r.id).toSet();
      expect(ids.length, kInitialRecipes.length);
    });

    for (final recipe in kInitialRecipes) {
      group(recipe.title, () {
        test('2-3 altın kural ve saklama ipucu var', () {
          expect(recipe.chefGoldenRules.length, inInclusiveRange(2, 3));
          expect(recipe.storageAndReheatingTip.trim(), isNotEmpty);
          expect(recipe.subtitle.trim(), isNotEmpty);
        });

        test('makrolar ve süreler gerçekçi', () {
          expect(recipe.macros.kcal, inInclusiveRange(300, 1100));
          expect(recipe.macros.proteinG, greaterThan(10));
          expect(recipe.prepTimeMinutes + recipe.cookTimeMinutes, inInclusiveRange(10, 60));
          expect(recipe.baseServings, greaterThanOrEqualTo(1));
          expect(recipe.tags, isNotEmpty);
        });

        test('malzemeler: miktar > 0; anahtar malzemelerde market ipucu var', () {
          expect(recipe.ingredients.length, greaterThanOrEqualTo(7));
          expect(recipe.ingredients.every((i) => i.amount > 0), isTrue);
          final withTip = recipe.ingredients.where((i) => (i.buyingTip ?? '').isNotEmpty).length;
          expect(withTip / recipe.ingredients.length, greaterThanOrEqualTo(0.6),
              reason: 'Malzemelerin en az %60\'ında buying_tip olmalı');
          final withSub =
              recipe.ingredients.where((i) => (i.substituteOption ?? '').isNotEmpty).length;
          expect(withSub, greaterThanOrEqualTo(3));
        });

        test('adımlar: ardışık numara, sensory_cue ve chef_tip dolu', () {
          expect(recipe.steps.length, greaterThanOrEqualTo(5));
          for (final (i, s) in recipe.steps.indexed) {
            expect(s.stepNumber, i + 1);
            expect(s.title.trim(), isNotEmpty);
            expect(s.instruction.trim(), isNotEmpty);
            expect(s.sensoryCue.trim(), isNotEmpty, reason: 'Adım ${s.stepNumber}');
            expect(s.chefTip.trim(), isNotEmpty, reason: 'Adım ${s.stepNumber}');
            if (s.timerSeconds != null) expect(s.timerSeconds, greaterThan(0));
          }
          expect(recipe.steps.any((s) => s.timerSeconds != null), isTrue);
        });

        test('JSON gidiş-dönüş kayıpsız (Gemini şema uyumu)', () {
          final restored = Recipe.fromJson(
            recipe.toJson(),
            id: recipe.id,
          );
          expect(restored.toJson(), recipe.toJson());
          expect(restored.ingredients, recipe.ingredients);
          expect(restored.steps, recipe.steps);
        });
      });
    }
  });
}
