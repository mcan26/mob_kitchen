import 'package:flutter/material.dart';

import '../../features/profile/domain/entities/personal_taste_profile.dart';
import '../../features/recipes/domain/entities/recipe.dart';
import '../../features/recipes/domain/entities/recipe_enums.dart';

/// Editorial culinary visual specification for recipes, photography, and category themes.
class RecipeVisualSpec {
  const RecipeVisualSpec({
    required this.gradientColors,
    required this.accentColor,
    required this.dishEmoji,
    required this.culinaryBadge,
    required this.icon,
    this.imageUrl,
  });

  final List<Color> gradientColors;
  final Color accentColor;
  final String dishEmoji;
  final String culinaryBadge;
  final IconData icon;
  final String? imageUrl;
}

abstract final class RecipeVisuals {
  static RecipeVisualSpec forRecipe(Recipe recipe) {
    switch (recipe.id) {
      case 'mob_classic_001':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4A2511), Color(0xFF281815), Color(0xFF15151C)],
          accentColor: Color(0xFFFF8A50),
          dishEmoji: '🍝',
          culinaryBadge: 'CREAMY & GARLIC',
          icon: Icons.dinner_dining,
          imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281691?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_002':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4F3810), Color(0xFF292014), Color(0xFF15151C)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '🧀',
          culinaryBadge: 'ROMAN CLASSIC',
          icon: Icons.restaurant,
          imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_003':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF521E14), Color(0xFF2B1615), Color(0xFF15151C)],
          accentColor: Color(0xFFE84A27),
          dishEmoji: '🍗',
          culinaryBadge: 'DOUBLE CRUNCH',
          icon: Icons.local_fire_department,
          imageUrl: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_004':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1E3F29), Color(0xFF172620), Color(0xFF15151C)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🌯',
          culinaryBadge: 'MEAL PREP HERO',
          icon: Icons.rice_bowl,
          imageUrl: 'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_005':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF541B1B), Color(0xFF2E1719), Color(0xFF15151C)],
          accentColor: Color(0xFFFF5E4D),
          dishEmoji: '🍳',
          culinaryBadge: 'ONE-PAN SHAKSHUKA',
          icon: Icons.egg_alt,
          imageUrl: 'https://images.unsplash.com/photo-1590412200988-a436970781fa?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_006':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF3E1F14), Color(0xFF231618), Color(0xFF15151C)],
          accentColor: Color(0xFFFF9F43),
          dishEmoji: '🥢',
          culinaryBadge: '15-MIN ASIAN BOWL',
          icon: Icons.ramen_dining,
          imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_007':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF472A14), Color(0xFF261B16), Color(0xFF15151C)],
          accentColor: Color(0xFFF39C12),
          dishEmoji: '🥔',
          culinaryBadge: 'CRISPY SKILLET HASH',
          icon: Icons.soup_kitchen,
          imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_008':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1B3B48), Color(0xFF17242E), Color(0xFF15151C)],
          accentColor: Color(0xFF48DBFB),
          dishEmoji: '🍋',
          culinaryBadge: 'PANTRY 15-MINUTE',
          icon: Icons.set_meal,
          imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_009':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF561818), Color(0xFF2B1418), Color(0xFF15151C)],
          accentColor: Color(0xFFFF5252),
          dishEmoji: '🌶️',
          culinaryBadge: 'CRISPY PANKO TEXTURE',
          icon: Icons.whatshot,
          imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_010':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4A1F12), Color(0xFF281715), Color(0xFF15151C)],
          accentColor: Color(0xFFFF793F),
          dishEmoji: '🍔',
          culinaryBadge: 'MAILLARD SMASH CRUST',
          icon: Icons.lunch_dining,
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_011':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4E1D1D), Color(0xFF2B1618), Color(0xFF15151C)],
          accentColor: Color(0xFFFF5252),
          dishEmoji: '🌿',
          culinaryBadge: 'STREET FOOD CLASSIC',
          icon: Icons.local_fire_department,
          imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_012':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF382F22), Color(0xFF201B14), Color(0xFF15151C)],
          accentColor: Color(0xFFE5B567),
          dishEmoji: '🍄',
          culinaryBadge: 'ALL\'ONDA TEXTURE',
          icon: Icons.rice_bowl,
          imageUrl: 'https://images.unsplash.com/photo-1633964913295-ceb43826e7c9?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_013':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1D3B47), Color(0xFF15222E), Color(0xFF15151C)],
          accentColor: Color(0xFFFF8552),
          dishEmoji: '🐟',
          culinaryBadge: 'CRISPY SKIN CRACKLING',
          icon: Icons.set_meal,
          imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_014':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4B3914), Color(0xFF282012), Color(0xFF15151C)],
          accentColor: Color(0xFFF39C12),
          dishEmoji: '🥥',
          culinaryBadge: 'GOLDEN COCONUT',
          icon: Icons.soup_kitchen,
          imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_015':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF3B1E14), Color(0xFF231614), Color(0xFF15151C)],
          accentColor: Color(0xFFFF793F),
          dishEmoji: '🥩',
          culinaryBadge: 'SESAME BULGOGI',
          icon: Icons.dinner_dining,
          imageUrl: 'https://images.unsplash.com/photo-1590301157890-4810ed352733?auto=format&fit=crop&w=1000&q=85',
        );
      case 'mob_classic_016':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF542410), Color(0xFF2D1610), Color(0xFF15151C)],
          accentColor: Color(0xFFFF7043),
          dishEmoji: '🍛',
          culinaryBadge: 'SILKY MAKHANI',
          icon: Icons.soup_kitchen,
          imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1000&q=85',
        );
    }

    if (!recipe.isBuiltIn) {
      if (recipe.id.startsWith('social_')) {
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1B3A4B), Color(0xFF1D2238), Color(0xFF14141C)],
          accentColor: Color(0xFF00D2D3),
          dishEmoji: '📲',
          culinaryBadge: 'SOCIAL MEDIA IMPORT',
          icon: Icons.bolt_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1000&q=85',
        );
      }
      if (recipe.id.startsWith('ai_') || recipe.sourceRecipeId != null) {
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF3E1E3D), Color(0xFF23182E), Color(0xFF14141C)],
          accentColor: Color(0xFFFF6F43),
          dishEmoji: '✨',
          culinaryBadge: 'AI CHEF CREATION',
          icon: Icons.auto_awesome,
          imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=1000&q=85',
        );
      }
      return const RecipeVisualSpec(
        gradientColors: [Color(0xFF422816), Color(0xFF241814), Color(0xFF14141C)],
        accentColor: Color(0xFFF5A623),
        dishEmoji: '👨‍🍳',
        culinaryBadge: 'MY SIGNATURE',
        icon: Icons.soup_kitchen,
        imageUrl: 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?auto=format&fit=crop&w=1000&q=85',
      );
    }

    return switch (recipe.category) {
      RecipeCategory.onePot => const RecipeVisualSpec(
          gradientColors: [Color(0xFF482315), Color(0xFF1E1A24)],
          accentColor: Color(0xFFE84A27),
          dishEmoji: '🥘',
          culinaryBadge: 'ONE-PAN',
          icon: Icons.soup_kitchen,
          imageUrl: 'https://images.unsplash.com/photo-1590412200988-a436970781fa?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.pasta => const RecipeVisualSpec(
          gradientColors: [Color(0xFF4D3412), Color(0xFF1E1A24)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '🍝',
          culinaryBadge: 'ITALIAN PASTA',
          icon: Icons.dinner_dining,
          imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.crispyChicken => const RecipeVisualSpec(
          gradientColors: [Color(0xFF521E14), Color(0xFF1E1A24)],
          accentColor: Color(0xFFFF6F43),
          dishEmoji: '🍗',
          culinaryBadge: 'CRISPY CHICKEN',
          icon: Icons.local_fire_department,
          imageUrl: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.bowl => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1E3F29), Color(0xFF1A2026)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🥣',
          culinaryBadge: 'POWER BOWL',
          icon: Icons.rice_bowl,
          imageUrl: 'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.highProtein => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1D3E2A), Color(0xFF1A2026)],
          accentColor: Color(0xFF27AE60),
          dishEmoji: '💪',
          culinaryBadge: 'HIGH PROTEIN',
          icon: Icons.fitness_center,
          imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.quickDinner => const RecipeVisualSpec(
          gradientColors: [Color(0xFF3D2214), Color(0xFF1A1C24)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '⚡',
          culinaryBadge: 'QUICK DINNER',
          icon: Icons.bolt,
          imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1000&q=85',
        ),
      RecipeCategory.budget => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1F3833), Color(0xFF181C24)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🪙',
          culinaryBadge: 'BUDGET FRIENDLY',
          icon: Icons.savings_outlined,
          imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=1000&q=85',
        ),
    };
  }

  /// Returns allergen or disliked ingredient warnings matching the user profile.
  static List<String> findAllergenOrDislikeWarnings(
    Recipe recipe,
    PersonalTasteProfile profile,
  ) {
    final warnings = <String>[];
    final ingText = recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

    for (final allergy in profile.allergies) {
      final token = allergy.trim().toLowerCase();
      if (token.isNotEmpty && ingText.contains(token)) {
        warnings.add('Allergen Warning: $allergy');
      }
    }
    for (final disliked in profile.dislikedIngredients) {
      final token = disliked.trim().toLowerCase();
      if (token.isNotEmpty && ingText.contains(token)) {
        warnings.add('Disliked Ingredient: $disliked');
      }
    }
    return warnings;
  }
}
