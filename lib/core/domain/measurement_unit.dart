/// Ölçü birimlerinin ailesi. Aynı aile içindeki birimler birbirine
/// dönüştürülerek birleştirilebilir (örn. yemek kaşığı + ml).
enum UnitFamily { mass, volume, count }

/// Tarif ve alışveriş listesi için standart ölçü birimleri.
///
/// [baseFactor]: Aile içindeki taban birime (mass → g, volume → ml) çarpan.
/// Sayılabilir (count) birimlerde null'dır; bunlar birbirine dönüştürülmez.
enum MeasurementUnit {
  gram('g', 'g', UnitFamily.mass, 1),
  milliliter('ml', 'ml', UnitFamily.volume, 1),
  cup('cup', 'cup', UnitFamily.volume, 240),
  tablespoon('tbsp', 'tbsp', UnitFamily.volume, 15),
  teaspoon('tsp', 'tsp', UnitFamily.volume, 5),
  piece('piece', 'pc', UnitFamily.count, null),
  clove('clove', 'clove', UnitFamily.count, null),
  slice('slice', 'slice', UnitFamily.count, null),
  bunch('bunch', 'bunch', UnitFamily.count, null),
  pinch('pinch', 'pinch', UnitFamily.count, null),
  pack('pack', 'pack', UnitFamily.count, null),
  can('can', 'can', UnitFamily.count, null);

  const MeasurementUnit(this.jsonValue, this.label, this.family, this.baseFactor);

  final String jsonValue;
  final String label;
  final UnitFamily family;
  final double? baseFactor;

  static MeasurementUnit fromJson(String? value) {
    if (value == null) return MeasurementUnit.piece;
    final normalized = value.trim().toLowerCase();
    return MeasurementUnit.values.firstWhere(
      (e) => e.jsonValue == normalized || e.name.toLowerCase() == normalized,
      orElse: () => MeasurementUnit.piece,
    );
  }

  static List<String> get jsonValues => values.map((e) => e.jsonValue).toList();
}
