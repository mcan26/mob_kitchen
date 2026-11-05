import 'package:equatable/equatable.dart';

import 'macros.dart';
import 'recipe_enums.dart';
import 'recipe_ingredient.dart';
import 'recipe_step.dart';

class Recipe extends Equatable {
  const Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.baseServings,
    required this.difficulty,
    required this.macros,
    required this.tags,
    required this.chefGoldenRules,
    required this.storageAndReheatingTip,
    required this.ingredients,
    required this.steps,
    this.isBuiltIn = false,
    this.isFavorite = false,
    this.sourceRecipeId,
    this.createdAt,
  });

  /// Yerleşik tariflerde sabit (örn. `mob_classic_001`), AI tariflerinde UUID.
  final String id;
  final String title;
  final String subtitle;
  final RecipeCategory category;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int baseServings;
  final Difficulty difficulty;

  /// Porsiyon başına.
  final Macros macros;
  final List<String> tags;

  /// Tarifin başında okunacak 2-3 altın kural.
  final List<String> chefGoldenRules;
  final String storageAndReheatingTip;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;

  final bool isBuiltIn;
  final bool isFavorite;

  /// AI Remix ile türetilmişse kaynak tarifin id'si.
  final String? sourceRecipeId;
  final DateTime? createdAt;

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  /// Gemini `responseSchema` ile birebir uyumlu JSON.
  /// `id`, `is_built_in`, `is_favorite` gibi uygulama alanları Gemini'den beklenmez;
  /// [fromJson] bunlar için [id] parametresi ve varsayılanlar kullanır.
  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    required String id,
    bool isBuiltIn = false,
    bool isFavorite = false,
    String? sourceRecipeId,
    DateTime? createdAt,
  }) =>
      Recipe(
        id: id,
        title: (json['title'] as String?)?.trim() ?? 'Yeni Tarif',
        subtitle: (json['subtitle'] as String?)?.trim() ?? '',
        category: RecipeCategory.fromJson(json['category'] as String?),
        prepTimeMinutes: (json['prep_time'] as num?)?.toInt() ?? 10,
        cookTimeMinutes: (json['cook_time'] as num?)?.toInt() ?? 15,
        baseServings: (json['base_servings'] as num?)?.toInt() ?? 2,
        difficulty: Difficulty.fromJson(json['difficulty'] as String?),
        macros: Macros.fromJson(json['macros'] as Map<String, dynamic>?),
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        chefGoldenRules:
            (json['chef_golden_rules'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        storageAndReheatingTip: (json['storage_and_reheating_tip'] as String?)?.trim() ??
            'Buzdolabında 2 gün saklanabilir.',
        ingredients: (json['ingredients'] as List?)
                ?.map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        steps: (json['steps'] as List?)
                ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        isBuiltIn: isBuiltIn,
        isFavorite: isFavorite,
        sourceRecipeId: sourceRecipeId,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'category': category.jsonValue,
        'prep_time': prepTimeMinutes,
        'cook_time': cookTimeMinutes,
        'base_servings': baseServings,
        'difficulty': difficulty.jsonValue,
        'macros': macros.toJson(),
        'tags': tags,
        'chef_golden_rules': chefGoldenRules,
        'storage_and_reheating_tip': storageAndReheatingTip,
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
        'steps': steps.map((e) => e.toJson()).toList(),
      };

  Recipe copyWith({
    String? id,
    bool? isFavorite,
    bool? isBuiltIn,
    String? sourceRecipeId,
    DateTime? createdAt,
  }) =>
      Recipe(
        id: id ?? this.id,
        title: title,
        subtitle: subtitle,
        category: category,
        prepTimeMinutes: prepTimeMinutes,
        cookTimeMinutes: cookTimeMinutes,
        baseServings: baseServings,
        difficulty: difficulty,
        macros: macros,
        tags: tags,
        chefGoldenRules: chefGoldenRules,
        storageAndReheatingTip: storageAndReheatingTip,
        ingredients: ingredients,
        steps: steps,
        isBuiltIn: isBuiltIn ?? this.isBuiltIn,
        isFavorite: isFavorite ?? this.isFavorite,
        sourceRecipeId: sourceRecipeId ?? this.sourceRecipeId,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        category,
        prepTimeMinutes,
        cookTimeMinutes,
        baseServings,
        difficulty,
        macros,
        tags,
        chefGoldenRules,
        storageAndReheatingTip,
        ingredients,
        steps,
        isBuiltIn,
        isFavorite,
        sourceRecipeId,
        createdAt,
      ];
}
