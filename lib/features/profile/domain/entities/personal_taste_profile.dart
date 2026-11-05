import 'package:equatable/equatable.dart';

/// Mutfaktaki ekipmanlar. Gemini'ye "fırın yok" gibi kısıtları iletmek için kullanılır.
enum KitchenEquipment {
  pan('pan', 'Frying pan'),
  pot('pot', 'Pot'),
  airfryer('airfryer', 'Airfryer'),
  oven('oven', 'Oven'),
  microwave('microwave', 'Microwave'),
  blender('blender', 'Blender'),
  riceCooker('rice_cooker', 'Rice cooker');

  const KitchenEquipment(this.jsonValue, this.label);
  final String jsonValue;
  final String label;

  static KitchenEquipment fromJson(String v) =>
      values.firstWhere((e) => e.jsonValue == v, orElse: () => throw FormatException('Unknown equipment: $v'));
}

/// Kullanıcının kişisel damak tadı ve mutfak kısıtları.
/// FAZ 2'de her Gemini isteğinin system prompt'una otomatik enjekte edilir.
class PersonalTasteProfile extends Equatable {
  const PersonalTasteProfile({
    this.equipment = const {KitchenEquipment.pan, KitchenEquipment.pot, KitchenEquipment.airfryer},
    this.dietGoals = const ['High protein'],
    this.dislikedIngredients = const [],
    this.allergies = const [],
    this.spiceLevel = 2,
    this.defaultServings = 2,
    this.extraNotes = '',
  });

  /// Elimdeki ekipmanlar. Listede olmayan (örn. fırın) ekipman gerektiren tarifler uyarlanır.
  final Set<KitchenEquipment> equipment;

  /// Örn: "Yüksek protein", "Düşük karbonhidrat", "Bütçe dostu".
  final List<String> dietGoals;
  final List<String> dislikedIngredients;
  final List<String> allergies;

  /// 0 (acı yok) – 3 (çok acı).
  final int spiceLevel;
  final int defaultServings;

  /// Serbest not: "Kişniş sevmem, tavuk budu tercih ederim" gibi.
  final String extraNotes;

  bool get hasOven => equipment.contains(KitchenEquipment.oven);

  factory PersonalTasteProfile.fromJson(Map<String, dynamic> json) => PersonalTasteProfile(
        equipment: (json['equipment'] as List).cast<String>().map(KitchenEquipment.fromJson).toSet(),
        dietGoals: (json['diet_goals'] as List).cast<String>(),
        dislikedIngredients: (json['disliked_ingredients'] as List).cast<String>(),
        allergies: (json['allergies'] as List).cast<String>(),
        spiceLevel: (json['spice_level'] as num).toInt(),
        defaultServings: (json['default_servings'] as num).toInt(),
        extraNotes: json['extra_notes'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'equipment': equipment.map((e) => e.jsonValue).toList(),
        'diet_goals': dietGoals,
        'disliked_ingredients': dislikedIngredients,
        'allergies': allergies,
        'spice_level': spiceLevel,
        'default_servings': defaultServings,
        'extra_notes': extraNotes,
      };

  PersonalTasteProfile copyWith({
    Set<KitchenEquipment>? equipment,
    List<String>? dietGoals,
    List<String>? dislikedIngredients,
    List<String>? allergies,
    int? spiceLevel,
    int? defaultServings,
    String? extraNotes,
  }) =>
      PersonalTasteProfile(
        equipment: equipment ?? this.equipment,
        dietGoals: dietGoals ?? this.dietGoals,
        dislikedIngredients: dislikedIngredients ?? this.dislikedIngredients,
        allergies: allergies ?? this.allergies,
        spiceLevel: spiceLevel ?? this.spiceLevel,
        defaultServings: defaultServings ?? this.defaultServings,
        extraNotes: extraNotes ?? this.extraNotes,
      );

  @override
  List<Object?> get props =>
      [equipment, dietGoals, dislikedIngredients, allergies, spiceLevel, defaultServings, extraNotes];
}
