import 'package:equatable/equatable.dart';

import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';

/// Tarifin bir malzemesi + markette nasıl seçileceği / alternatifi.
class RecipeIngredient extends Equatable {
  const RecipeIngredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.aisleCategory,
    this.preparationNote,
    this.buyingTip,
    this.substituteOption,
  });

  final String name;

  /// Tarifin `baseServings` porsiyonu için miktar.
  final double amount;
  final MeasurementUnit unit;
  final AisleCategory aisleCategory;

  /// Örn: "küp doğranmış", "ince kıyılmış".
  final String? preparationNote;

  /// Markette raftan nasıl seçileceği.
  final String? buyingTip;

  /// Bulunamazsa / pahalıysa ne alınabileceği.
  final String? substituteOption;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) => RecipeIngredient(
        name: (json['name'] as String?)?.trim() ?? 'Malzeme',
        amount: (json['amount'] as num?)?.toDouble() ?? 1.0,
        unit: MeasurementUnit.fromJson(json['unit'] as String?),
        aisleCategory: AisleCategory.fromJson(json['aisle_category'] as String?),
        preparationNote: json['preparation_note'] as String?,
        buyingTip: json['buying_tip'] as String?,
        substituteOption: json['substitute_option'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'unit': unit.jsonValue,
        'aisle_category': aisleCategory.jsonValue,
        'preparation_note': preparationNote,
        'buying_tip': buyingTip,
        'substitute_option': substituteOption,
      };

  RecipeIngredient copyWith({double? amount}) => RecipeIngredient(
        name: name,
        amount: amount ?? this.amount,
        unit: unit,
        aisleCategory: aisleCategory,
        preparationNote: preparationNote,
        buyingTip: buyingTip,
        substituteOption: substituteOption,
      );

  @override
  List<Object?> get props =>
      [name, amount, unit, aisleCategory, preparationNote, buyingTip, substituteOption];
}
