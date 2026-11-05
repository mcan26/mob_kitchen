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
  cup('cup', 'su bardağı', UnitFamily.volume, 200),
  tablespoon('tbsp', 'yemek kaşığı', UnitFamily.volume, 15),
  teaspoon('tsp', 'çay kaşığı', UnitFamily.volume, 5),
  piece('piece', 'adet', UnitFamily.count, null),
  clove('clove', 'diş', UnitFamily.count, null),
  slice('slice', 'dilim', UnitFamily.count, null),
  bunch('bunch', 'demet', UnitFamily.count, null),
  pinch('pinch', 'tutam', UnitFamily.count, null),
  pack('pack', 'paket', UnitFamily.count, null),
  can('can', 'kutu', UnitFamily.count, null);

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
