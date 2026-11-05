/// Mob tarzı tarif kategorileri.
enum RecipeCategory {
  onePot('one_pot', 'One-Pan'),
  quickDinner('quick_dinner', '20-Minute Dinner'),
  highProtein('high_protein', 'High-Protein'),
  budget('budget', 'Budget-Friendly'),
  crispyChicken('crispy_chicken', 'Crispy Chicken'),
  pasta('pasta', 'Pasta'),
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
  easy('easy', 'Easy'),
  medium('medium', 'Medium'),
  hard('hard', 'Hard');

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
