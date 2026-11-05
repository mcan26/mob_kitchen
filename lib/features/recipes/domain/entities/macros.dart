import 'package:equatable/equatable.dart';

/// Porsiyon başına makro değerleri (tahmini).
class Macros extends Equatable {
  const Macros({
    required this.kcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
  });

  final int kcal;
  final int proteinG;
  final int carbsG;
  final int fatG;

  factory Macros.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Macros(kcal: 500, proteinG: 30, carbsG: 50, fatG: 20);
    }
    return Macros(
      kcal: (json['kcal'] as num?)?.round() ?? 500,
      proteinG: (json['protein'] as num?)?.round() ?? 30,
      carbsG: (json['carbs'] as num?)?.round() ?? 50,
      fatG: (json['fat'] as num?)?.round() ?? 20,
    );
  }

  Map<String, dynamic> toJson() => {
        'kcal': kcal,
        'protein': proteinG,
        'carbs': carbsG,
        'fat': fatG,
      };

  @override
  List<Object?> get props => [kcal, proteinG, carbsG, fatG];
}
