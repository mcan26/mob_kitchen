import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';
import '../../../recipes/domain/entities/recipe.dart';
import '../../../recipes/domain/services/portion_scaler.dart';
import '../entities/shopping_list_item.dart';

/// Alışveriş planına eklenen tarif ve hedef porsiyon bilgisi.
class ShoppingPlanEntry {
  const ShoppingPlanEntry({
    required this.recipe,
    required this.servings,
  });

  final Recipe recipe;
  final int servings;
}

/// Akıllı market listesi birleştirici.
///
/// Farklı tariflerdeki aynı malzemeleri tespit eder:
/// - Ağırlık birimlerini (`g`) normalize eder ve toplar.
/// - Hacim birimlerini (`tsp`, `tbsp`, `cup`, `ml`) `ml` tabanında normalize eder ve toplar.
/// - Sayılabilir birimleri (`piece`, `clove`, `can` vb.) aynı birimde toplar.
/// - `buying_tip`, `substitute_option` ve `source_recipe_titles` bilgilerini tek kalemde birleştirir.
/// - Reyon sırasına (`AisleCategory.shoppingOrder`) göre dizer.
class SmartShoppingAggregator {
  const SmartShoppingAggregator._();

  static List<ShoppingListItem> aggregate({
    required List<ShoppingPlanEntry> planEntries,
    Map<String, bool> existingCheckedStates = const {},
  }) {
    if (planEntries.isEmpty) return const [];

    final groups = <String, _AggregatedGroup>{};

    for (final entry in planEntries) {
      final recipe = entry.recipe;
      final targetServings = entry.servings;

      for (final ing in recipe.ingredients) {
        final scaledIng = PortionScaler.scaleIngredient(
          ing,
          baseServings: recipe.baseServings,
          targetServings: targetServings,
        );

        final normalizedName = _normalizeIngredientName(scaledIng.name);
        final (groupKey, normalizedAmount, standardUnit) =
            _normalizeAmountAndUnit(normalizedName, scaledIng.amount, scaledIng.unit);

        final group = groups.putIfAbsent(
          groupKey,
          () => _AggregatedGroup(
            id: groupKey,
            displayName: _capitalize(normalizedName),
            unit: standardUnit,
            aisleCategory: scaledIng.aisleCategory,
          ),
        );

        group.add(
          amount: normalizedAmount,
          recipeTitle: recipe.title,
          buyingTip: scaledIng.buyingTip,
          substituteOption: scaledIng.substituteOption,
          aisleCategory: scaledIng.aisleCategory,
        );
      }
    }

    final items = groups.values.map((g) {
      final isChecked = existingCheckedStates[g.id] ?? false;
      return g.toShoppingListItem(isChecked: isChecked);
    }).toList();

    // Aisle shopping order (Produce -> Butcher -> Dairy -> Bakery -> Pantry -> Spices), then by name
    items.sort((a, b) {
      final aisleCmp = a.aisleCategory.shoppingOrder.compareTo(b.aisleCategory.shoppingOrder);
      if (aisleCmp != 0) return aisleCmp;
      return a.name.compareTo(b.name);
    });

    return items;
  }

  /// Cleans ingredient names for grouping: removes parenthesized prep notes
  /// and trailing comma descriptors.
  static String _normalizeIngredientName(String name) {
    var cleaned = name
        .toLowerCase()
        .replaceAll(RegExp(r'\([^)]*\)'), ' ') // Parantez içini kaldır
        .split(',')
        .first // Virgülden önceki ana malzeme adını al
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (cleaned.isEmpty) {
      cleaned = name.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
    }
    return cleaned;
  }

  /// Birim normalizasyonu:
  /// - Ağırlık (`UnitFamily.mass`) -> `gram` (1g)
  /// - Hacim (`UnitFamily.volume`) -> `milliliter` (ml)
  /// - Sayılabilir (`UnitFamily.count`) -> Kendi birimiyle ayrıştırılır
  static (String groupKey, double normalizedAmount, MeasurementUnit standardUnit)
      _normalizeAmountAndUnit(String normalizedName, double amount, MeasurementUnit unit) {
    switch (unit.family) {
      case UnitFamily.mass:
        final factor = unit.baseFactor ?? 1.0;
        final grams = amount * factor;
        return ('${normalizedName}_mass', grams, MeasurementUnit.gram);

      case UnitFamily.volume:
        final factor = unit.baseFactor ?? 1.0;
        final ml = amount * factor;
        return ('${normalizedName}_volume', ml, MeasurementUnit.milliliter);

      case UnitFamily.count:
        return ('${normalizedName}_${unit.jsonValue}', amount, unit);
    }
  }

  static String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

class _AggregatedGroup {
  _AggregatedGroup({
    required this.id,
    required this.displayName,
    required this.unit,
    required this.aisleCategory,
  });

  final String id;
  final String displayName;
  final MeasurementUnit unit;
  AisleCategory aisleCategory;

  double totalAmount = 0.0;
  final Set<String> recipeTitles = {};
  final Set<String> buyingTips = {};
  final Set<String> substituteOptions = {};

  void add({
    required double amount,
    required String recipeTitle,
    required String? buyingTip,
    required String? substituteOption,
    required AisleCategory aisleCategory,
  }) {
    totalAmount += amount;
    recipeTitles.add(recipeTitle);

    if (buyingTip != null && buyingTip.trim().isNotEmpty) {
      buyingTips.add(buyingTip.trim());
    }
    if (substituteOption != null && substituteOption.trim().isNotEmpty) {
      substituteOptions.add(substituteOption.trim());
    }

    // Eğer önceki kategori pantry ise ve yeni gelen daha spesifik ise (örn. butcherDeli / produce), yükselt
    if (this.aisleCategory == AisleCategory.pantry && aisleCategory != AisleCategory.pantry) {
      this.aisleCategory = aisleCategory;
    }
  }

  ShoppingListItem toShoppingListItem({required bool isChecked}) {
    final combinedBuyingTip = buyingTips.isEmpty ? null : buyingTips.join(' • ');
    final combinedSubstitute = substituteOptions.isEmpty ? null : substituteOptions.join(' • ');

    // Mutfak yuvarlaması
    final roundedAmount = PortionScaler.roundCulinaryAmount(totalAmount, unit);

    return ShoppingListItem(
      id: id,
      name: displayName,
      aggregatedAmount: roundedAmount,
      unit: unit,
      aisleCategory: aisleCategory,
      buyingTip: combinedBuyingTip,
      substituteOption: combinedSubstitute,
      isChecked: isChecked,
      sourceRecipeTitles: recipeTitles.toList()..sort(),
    );
  }
}
