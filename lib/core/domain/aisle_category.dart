/// Market reyonları. Alışveriş listesi bu sıraya göre gruplanır
/// (markette dolaşma sırası: Manav → Kasap → Süt → Fırın → Bakliyat → Baharat).
enum AisleCategory {
  produce('produce', 'Manav', 0),
  butcherDeli('butcher_deli', 'Kasap / Şarküteri', 1),
  dairy('dairy', 'Süt Ürünleri', 2),
  bakery('bakery', 'Fırın / Ekmek', 3),
  pantry('pantry', 'Bakliyat / Makarna / Sos', 4),
  spices('spices', 'Baharat', 5);

  const AisleCategory(this.jsonValue, this.label, this.shoppingOrder);

  /// Gemini `responseSchema` enum değeri ve JSON serileştirme anahtarı.
  final String jsonValue;

  /// Kullanıcıya gösterilen Türkçe reyon adı.
  final String label;

  /// Market modunda reyonların sıralanması için.
  final int shoppingOrder;

  static AisleCategory fromJson(String? value) {
    if (value == null) return AisleCategory.pantry;
    final normalized = value.trim().toLowerCase();
    return AisleCategory.values.firstWhere(
      (e) => e.jsonValue == normalized || e.name.toLowerCase() == normalized,
      orElse: () => AisleCategory.pantry,
    );
  }

  static List<String> get jsonValues => values.map((e) => e.jsonValue).toList();
}
