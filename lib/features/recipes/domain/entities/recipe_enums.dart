/// Mob tarzı tarif kategorileri.
enum RecipeCategory {
  onePot('one_pot', 'Tek Tava'),
  quickDinner('quick_dinner', '20 Dakikalık Akşam'),
  highProtein('high_protein', 'Yüksek Protein'),
  budget('budget', 'Bütçe Dostu'),
  crispyChicken('crispy_chicken', 'Çıtır Tavuk'),
  pasta('pasta', 'Makarna'),
  bowl('bowl', 'Bowl');

  const RecipeCategory(this.jsonValue, this.label);

  final String jsonValue;
  final String label;

  static RecipeCategory fromJson(String? value) {
    if (value == null) return RecipeCategory.quickDinner;
    final normalized = value.trim().toLowerCase();
    return RecipeCategory.values.firstWhere(
      (e) => e.jsonValue == normalized || e.name.toLowerCase() == normalized,
      orElse: () => RecipeCategory.quickDinner,
    );
  }

  static List<String> get jsonValues => values.map((e) => e.jsonValue).toList();
}

enum Difficulty {
  easy('easy', 'Kolay'),
  medium('medium', 'Orta'),
  hard('hard', 'Zor');

  const Difficulty(this.jsonValue, this.label);

  final String jsonValue;
  final String label;

  static Difficulty fromJson(String? value) {
    if (value == null) return Difficulty.medium;
    final normalized = value.trim().toLowerCase();
    return Difficulty.values.firstWhere(
      (e) => e.jsonValue == normalized || e.name.toLowerCase() == normalized,
      orElse: () => Difficulty.medium,
    );
  }

  static List<String> get jsonValues => values.map((e) => e.jsonValue).toList();
}
