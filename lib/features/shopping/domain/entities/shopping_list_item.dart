import 'package:equatable/equatable.dart';

import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';

/// Alışveriş listesinin birleştirilmiş satırı (FAZ 2'deki `SmartShoppingAggregator` üretir).
class ShoppingListItem extends Equatable {
  const ShoppingListItem({
    required this.id,
    required this.name,
    required this.aggregatedAmount,
    required this.unit,
    required this.aisleCategory,
    required this.sourceRecipeTitles,
    this.buyingTip,
    this.substituteOption,
    this.isChecked = false,
  });

  final String id;
  final String name;
  final double aggregatedAmount;
  final MeasurementUnit unit;
  final AisleCategory aisleCategory;
  final String? buyingTip;
  final String? substituteOption;
  final bool isChecked;

  /// Bu malzemenin hangi tarifler için alındığı.
  final List<String> sourceRecipeTitles;

  ShoppingListItem copyWith({bool? isChecked}) => ShoppingListItem(
        id: id,
        name: name,
        aggregatedAmount: aggregatedAmount,
        unit: unit,
        aisleCategory: aisleCategory,
        sourceRecipeTitles: sourceRecipeTitles,
        buyingTip: buyingTip,
        substituteOption: substituteOption,
        isChecked: isChecked ?? this.isChecked,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        aggregatedAmount,
        unit,
        aisleCategory,
        buyingTip,
        substituteOption,
        isChecked,
        sourceRecipeTitles,
      ];
}
